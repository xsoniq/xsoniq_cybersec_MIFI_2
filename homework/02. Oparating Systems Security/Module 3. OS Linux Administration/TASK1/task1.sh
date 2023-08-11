#!/bin/bash

### 1 ###
### Checking if the Backports repo is in the source.list ###

echo "Checking /etc/apt/sources.list"
sleep 2

if grep -R "jammy-backports" /etc/apt/sources.list
then
    echo -n "Backports Repository already exists!"
    sleep 2
else
    echo -n "Backports Repository not found!\n"
    echo -n "Adding Backports Repository to /etc/apt/sources.list\n"
    echo "deb http://archive.ubuntu.com/ubuntu jammy-backports main restricted universe multiverse\n" | sudo sh -c 'cat >> /etc/apt/sources.list'
    sleep 2
    echo "Backports Repository has been added to  /etc/apt/sources.list"
fi

### 2 ###
#### Update packages ###

echo "Starting update packages\n"
sleep 2
sudo apt update

# uncomment if you need system upgrade 
# sudo apt upgrade -y 

echo "Updated Successfully!\n"


### 3 ###
### Install Apache2 & Requirements & Check Apache ###

echo -n "Checking Apache Server \n"
sleep 2
if ! apache2 -v 2>/dev/null 
then
    echo -n "\n Apache Server not found!";
    sleep 2
    echo "Installing Apache Server"
    sleep 2
    sudo apt install apache2 apache2-doc apache2-utils -y
    echo -n "\n Apache Server Installed Successfully!\n"
    sleep 2
    apache2 -v
else
    echo "Apache Server already installed!"
fi

### Check Apache service ###
sleep 2
echo -n "\n Checking Apache Service Status"
sleep 2
if systemctl is-active -q apache2
then
    echo "Active (running)"
else
    echo "Inactive (stopped)"
fi

### 4 ###
### Install python ###

sudo apt update
echo "Installing Python\n"
sleep 2
echo "Installing important packages"
sudo apt install software-properties-common -y && echo "Done!\n"
sleep 2
echo "Installing repo for Python 3.10"
sudo add-apt-repository ppa:deadsnakes/ppa -y && echo "Done!\n"
sudo apt update
sudo apt install python3.10
sleep 2
echo "Python Installed Successfully! "
sleep 2
python3 --version 

### 5 ### 
### # Install & Setup SSH ###

sleep 2
echo "\n Checking SSH Server\n"
sleep 2

if ! ssh -V 2>/dev/null
then
    echo -n "SSH Server not found!";sleep 2; echo "Installing OpenSSH"
    sleep 2
    sudo apt install openssh-server -y
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
    sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
    # Change SSH port from 22 to 2222
    sudo sed -i -e 's/#Port 22/Port 2222\n#Port 22/g' /etc/ssh/sshd_config
    # Disable SSH password login
    sudo sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no\n#PasswordAuthentication yes/g' /etc/ssh/sshd_config
    sudo systemctl start ssh
    echo -n "OpenSSH Server Installed Successfully!";sleep 2; ssh -V
else
    ssh -V
    echo "SSH Server already installed!"
fi

### Check SSH service ###

sleep 2
echo -n "\n Checking SSH Service Status ${nocolor}"
if systemctl is-active -q ssh
then
    sleep 2
    echo "Active (running)"
else
    echo "Inactive (stopped)"
    sleep 2
    echo "\n Starting SSH Service"
    sleep 2
    sudo systemctl start ssh && echo "Done!"
fi

### 6 ###

### Install & Setup FTP ###
sleep 2
echo "\n Checking VSFTPD (Very Secure FTP Daemon) \n"
sleep 2
if ! vsftpd -version 2>/dev/null
then
    echo -n "VSFTPD not found!";sleep 2; echo "Installing VSFTPD"
    sleep 2
    sudo apt install vsftpd -y
# Backup /etc/vsftpd.conf
    sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.backup