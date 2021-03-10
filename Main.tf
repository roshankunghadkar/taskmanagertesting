provider "azurerm" {
   features {}
}


resource "azurerm_resource_group" "myterraformgroup" {
  name     = "${var.resourcegroup}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "mynetwork" {
  name                = "${var.vname}"
  address_space       = "${var.addressspace}"
  location            = "${azurerm_resource_group.myterraformgroup.location}"
  resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.subname}"
  resource_group_name  = "${azurerm_resource_group.myterraformgroup.name}"
  virtual_network_name = "${azurerm_virtual_network.mynetwork.name}"
  address_prefix     = "${var.addressprefix}"
}

resource "azurerm_network_security_group" "web_server_nsg"{
  name                 = "terraformdemo"
  location             = "${azurerm_resource_group.myterraformgroup.location}"
  resource_group_name  = "${azurerm_resource_group.myterraformgroup.name}"
}

resource "azurerm_network_security_rule" "web_server_nsg_rule_rdp" {
  name                         = "RDP Inbound"
  priority                     = 100
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "22"
  source_address_prefix        = "*"
  destination_address_prefix   = "*"
  resource_group_name          = "${azurerm_resource_group.myterraformgroup.name}"
  network_security_group_name  = "${azurerm_network_security_group.web_server_nsg.name}"
}

resource "azurerm_public_ip" "name"{
  name                 = "${var.publicip}"
  location             = "${azurerm_resource_group.myterraformgroup.location}"
  resource_group_name  = "${azurerm_resource_group.myterraformgroup.name}"
  allocation_method    = "Static"
}

resource "azurerm_network_interface" "demonic" {
  name                = "${var.machinename}"
  location            = "${azurerm_resource_group.myterraformgroup.location}"
  resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.name.id}"
  }
}

resource "azurerm_virtual_machine" "azurevm" {
  name                  = "${var.vmname}"
  location              = "${azurerm_resource_group.myterraformgroup.location}"
  resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
  network_interface_ids = ["${azurerm_network_interface.demonic.id}"]
  vm_size               = "${var.vmsize}"


  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "gslab"
    admin_password = "GSLab123"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }



  
}
resource "null_resource" "example" {

    connection {
        type = "ssh"
        user = "gslab"
        password = "GSLab123"
        host = azurerm_public_ip.name.ip_address
        port = 22
    }
    provisioner "file" {
        source = "/var/lib/jenkins/workspace/TestAutomation-PoC/script.sh"
        destination = "/tmp/script.sh"
    }
    

    provisioner "remote-exec" {
        inline = [
            "/bin/bash /tmp/script.sh"
            
        ]
    }

    
}

  
# Resources "azurerm_virtual_machine_extension" "practice" {
#   name                = "abc"
#   virtual_machine_id  = "${azurerm_virtual_machine.azurevm.id}"
#   publisher           = "Microsoft.Azure.Extensions"
#   type                = "CustomScript"
#   type_handler_version = "2.0"


#   protected_settings = <<PROTECTED_SETTINGS
# {
#     "script": "${base64encode(file(var.scfile))}"
# }
# PROTECTED_SETTINGS

# #   settings = <<SETTINGS
# #   {
# #     "commandToExecute": "./ script.sh",
# #     "fileUris": "https://gitlab.com/jiwnanimohit/project32/-/blob/master/script.sh"    
# #   }

# #   SETTINGS
#  }

output name {
  value       = "${azurerm_resource_group.myterraformgroup.name}"
}

output time {
  value       = "${timestamp()}"
}

output vmIP {
  value       = "${azurerm_public_ip.name.*.id}"
}

resource "local_file" "vmIP" {
    content  = "$${ip}  ${azurerm_public_ip.name.ip_address}"
    filename = "Ip.txt"
}
