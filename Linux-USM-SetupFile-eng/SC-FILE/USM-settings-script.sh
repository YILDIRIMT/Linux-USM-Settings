#!/bin/bash


# Desktop check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

    DESKTOP="$HOME/Desktop"

    if [ ! -d "$DESKTOP" ]; then

        zenity --info --title="Desktop Error" --text="ERROR: Desktop directory not found. Change the value of DESKTOP(5) inside the USMRemove.sh file to indicate your desktop location."

        exit

    fi

fi


# Tools check
if ! command -v zenity || command -v xterm || command -v vim; then
  echo -e "Installing Tools"

  sleep(1);

  if command -v apt &>/dev/null; then
    sudo apt install zenity xterm vim
  elif command -v yum &>/dev/null; then
    sudo yum install zenity xterm vim
  elif command -v dnf &>/dev/null; then
    sudo dnf install zenity xterm vim
  elif command -v pacman &>/dev/null; then
    sudo pacman -S zenity xterm vim
  else
    echo -e "\033[31mERROR: Unable to find package manager; therefore, automatic installation of the zenity, vim, and xterm packages could not be completed. You will need to manually install the zenity, vim, and xterm packages. \033[0m"
  fi

fi


# Operation
selection=$(zenity --list --title="Settings Script Selection" --text="Select Settings:" --column="USM-Settings-Script" "Create User" "Delete User" "Change Password" "System Update" "Window Opacity" "XFCE4 Panel Settings" "Other Settings (XFCE4 Settings)" "Remove This Program")

case "$selection" in
"Create User")
  bash ~/USM-S/create_user.sh
  ;;
"Delete User")
  bash ~/USM-S/delete_user.sh
  ;;
"Change Password")
  bash ~/USM-S/change_pass.sh
  ;;
"System Update")
  bash ~/USM-S/system_update.sh
  ;;
"Window Opacity")
  bash ~/USM-S/adjust_opacity.sh
  ;;
"XFCE4 Panel Settings")
  xfce4-panel --preferences
  ;;
"Other Settings (XFCE4 Settings)")
  xfce4-settings-manager
  ;;
"Remove This Program")
  "$DESKTOP"/Remove.sh
  ;;
*) ;;

esac


#Finish
