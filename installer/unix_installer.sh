#!/bin/bash

set -e
script_runner=$(whoami)
exec_path="/usr/local/bin/"
exec_name="pfox"
exec_full_path="${exec_path}${exec_name}"
mac_binary_download_url="https://github.com/diegomacario/Poor-Fox/releases/download/v1.0.0/pfox_macOS"
linux_binary_download_url="https://github.com/diegomacario/Poor-Fox/releases/download/v1.0.0/pfox_linux"

control_c()
{
    echo -en "\n\n*** Exiting ***\n\n"
    exit 1
}

trap control_c SIGINT

echo -e "\n"
echo "############################"
echo "#### Poor Fox Installer ####"
echo "############################"

# check if user is root
if [ $script_runner != "root" ] ; then
    echo -e "\nError: You must execute this script as a normal user with sudo privileges.\n"
    exit 1
fi

echo -e "\nThis script will simply download the binary for Poor Fox and place it under $exec_path\n"
if [[ $1 == "macos" ]]; then
    curl -L $mac_binary_download_url -o $exec_name || { echo -e "\nError: Something went wrong while trying to download the pfox binary for $1.\n"; exit 1; }
    sudo mv $exec_name $exec_path && chmod +x $exec_full_path
elif [[ $1 == "linux" ]]; then
    curl -L $linux_binary_download_url -o $exec_name || { echo -e "\nError: Something went wrong while trying to download the pfox binary for $1.\n"; exit 1; }
    sudo mv $exec_name $exec_path && chmod +x $exec_full_path
else
    echo -e "\nError: You need to specify the OS you are installing PoorFox on. Usage: bash unix_installer.sh [macos|linux]\n"
    exit 1
fi

echo -e "\nSuccessfully installed Poor Fox.\n"
