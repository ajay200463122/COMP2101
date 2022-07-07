#!/bin/bash

# Extra space a start
echo " "

# NOTE : >/dev/null is used in the if condition to avoid printing the output of the 
#	 command from the condition on console

# Checking if the lxd is already installed or not
# if not installed executing the command to install it
echo "***** Checking if lxd is installed or not *****"
if [ -e "/var/snap/lxd" ];
then
	echo "lxd is already installed!!!"
	echo " "
else
	echo "Installing lxd..."
	sudo snap install lxd
	echo " "
fi

# Checking if the lxdbr0 interface already exist or not
# if not, executing the command to initialize it
echo "***** Checking if lxdbr0 interface exist or not *****"
if ip l | grep lxdbr0 >/dev/null;
then
	echo "lxdbr0 interface already exists!!!"
	echo " "
else
	echo "Initializing lxd..."
	lxd init --auto
	echo " "
fi

# Checking if the container is already running or not
# if not, launching the container with name COMP2101-S22
echo "***** Checking if lxd container is running or not *****"
if lxc list | grep COMP2101-S22 >/dev/null;
then
	echo "lxd container COMP2101-S22 already exists!!!"
	echo " "
else
	echo "Launching lxd container..."
	lxc launch ubuntu:22.04 COMP2101-S22
	echo " "
fi

# Checking if there are already entry in the host file
# if not, adding an entry with the current IP address
echo "***** Checking if hosts file already has an entry or not *****"
if grep -q COMP2101-S22 /etc/hosts >/dev/null;
then
	echo "COMP2101-S22 is already associated with IP address!!!"
	echo " "
else
	echo "Adding COMP2101-S22 entry in hosts file with IP address..."
	IP=$(lxc list | grep COMP2101-S22 | egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")
	echo "$IP COMP2101-S22" | sudo tee -a /etc/hosts
	echo " "
fi

# Checking if apache2 is installed and running or not
# if not, installing the apache2 in the container
echo "***** Checking if apache2 is installed in container or not *****"
if lxc exec COMP2101-S22 service apache2 status >/dev/null;
then
	echo "apache2 is already installed in container!!!"
	echo " "
else
	echo "Installing apache2 in COMP2101-S22..."
	lxc exec COMP2101-S22 -- apt install apache2
	echo " "
fi

# Checking if we are able to retrieve the webpage using curl
# displaying the result of curl request
echo "***** Checking if we are able to retrieve default webpage or not *****"
if curl -s COMP2101-S22 >/dev/null;
then
	echo "Successfully retrieved the default web page"
else
	echo "Error occurred. Not able to fetch the default webpage"
fi

echo " "
