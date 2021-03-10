variable resourcegroup {
 # default     = "TestAutomationInfrastructure"
 type = string
}

variable location {
  #default     = "eastus"
  type = string
}

variable vname {
  default     = "Task-manager-server"
}

variable addressspace {
    type      = "list"
  default     = ["10.0.0.0/16"]
}

variable addressprefix {
  default     = "10.0.2.0/24"
}

variable subname {
  default     = "subnet"
}

# variable tag {
#   type      = "map"

#   default    {
#       "key" = "value"
#       "1"   = "2"
#       "tf"  = "res"
#   }
# }

variable publicip {
  default     = "publicipname"
}

variable machinename {
  default     = "Task-manager-server"
}

variable vmname {
  #default     = "Task-manager-server"
  type = string
}

variable vmsize {
  default     = "Standard_D2s_v3"
}

variable "scfile" {
  type = string
  default = "yu.bash"
}
