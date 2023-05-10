#!/bin/bash

# install SPiC development environment
sudo apt update
sudo apt upgrade -y
sudo apt install -y wget make udev gnupg apt-transport-https usbip hwdata usbutils sshpass
sudo /lib/systemd/systemd-udevd --daemon
wget -O - https://i4spic.cs.fau.de//editor/repo.gpg.key | sudo apt-key add -
echo "deb https://i4spic.cs.fau.de//editor/debian buster main" | sudo tee /etc/apt/sources.list.d/spic.list
sudo apt update
sudo apt install -y spic-editor
echo

# Ask for user credentials
read -p "Enter your Computer Science CIP username: " username
read -s -p "Enter your Computer Science CIP password: " password
echo

# Save cs cip username
echo "CS_USER=$username" > ~/.spic_env

# Create ssh key and send it to cs server
ssh-keygen -q -t rsa -b 4096 -f ~/.ssh/id_rsa -N ''
sshpass -p "$password" ssh-copy-id -i ~/.ssh/id_rsa -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $username@cipterm0.cip.cs.fau.de
echo
