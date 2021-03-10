#!/bin/sh

sudo apt update


#install mongodb
 wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
 echo "After wget"
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
 echo "After repository addition"
 sudo apt-get update
 echo "After update"
 sudo apt-get install -y mongodb-org
 echo "Done mongo"
 sudo systemctl start mongod

 echo "Starting mongod"
 sudo systemctl enable mongod

#Checking for mongodb
#mongo --eval "db.stats()"
RESULT=$?   

if [ $RESULT -ne 0 ]; then
    echo "mongodb not running"
    echo 'Installing Mongodb'
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "After wget"
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    echo "After repository addition"
    sudo apt-get update
    echo "After update"
    sudo apt-get install -y mongodb-org
    echo "Done mongo"
    sudo systemctl start mongod
    exit 1
else 
    echo "mongodb running!"
fi


 sudo apt update

#Installing python environment
sudo apt install python3-venv -y

#Cloning project
sudo git clone https://gitlab.com/roshankunghadkar/taskmanager

#Changing ownership of cloned project to gslab
sudo chown -R gslab /home/gslab/taskmanager

cd /home/gslab/taskmanager

python3.6 -m venv myprojectenv

source myprojectenv/bin/activate

echo "Installing Python dependencies"
 pip3 install wheel
 pip3 install flask
 pip3 install bson
 pip3 install mongoengine
 pip3 install flask-mongoengine
 pip3 install datetime
 pip3 install gunicorn



 sudo chown gslab /etc
 sudo chown gslab /etc/systemd
 sudo chown gslab /etc/systemd/system



#Verifying dependencies
if python3 -c 'import pkgutil; exit(not pkgutil.find_loader("flask"))'; then
    echo 'flask found'
else
    echo 'flask not found'
    echo 'Installing Flask'
    pip3 install flask
fi

if python3 -c 'import pkgutil; exit(not pkgutil.find_loader("mongoengine"))'; then
    echo 'mongoengine found'
else
    echo 'mongoengine not found'
    echo 'Installing Mongoengine'
    pip3 install mongoengine
    pip3 install flask-mongoengine
fi

if python3 -c 'import pkgutil; exit(not pkgutil.find_loader("bson"))'; then
    echo 'bson found'
else
    echo 'bson not found'
    echo 'Installing bson'
    pip3 install bson
fi

if python3 -c 'import pkgutil; exit(not pkgutil.find_loader("gunicorn"))'; then
    echo 'gunicorn found'
else
    echo 'gunicorn not found'
    echo 'Installing gunicorn'
    pip3 install gunicorn
fi

#Creating empty service file
sudo touch /etc/systemd/system/task.service

#Copying service to etc
sudo cp /home/gslab/taskmanager/project1.service  /etc/systemd/system/task.service
echo "Copied Successfully!!!!"

sudo chmod 777 /etc/systemd/system/task.service
#Starting the service
sudo systemctl start task.service


 echo "Running application"




 
