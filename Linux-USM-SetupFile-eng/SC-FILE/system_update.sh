#!/bin/bash

# Desktop check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

    echo -e "\033[31mERROR: Desktop directory not found. Modify the DESKTOP(4) value in the ~/USM-S/system_update.sh file to point to your desktop location. \033[0m"

    exit

  fi

fi

zenity --question --title="System Update" --text="Are you sure you want to update the system?"

if [[ $? -eq 0 ]]; then

  zenity --info --title="System Update" --text="After entering your password in the terminal, the update process will begin."

  # Operation
  # Checking the package installer
  if command -v apt &>/dev/null; then
    xterm -e "sudo apt update && upgrade"
    zenity --info --title="System Update" --text="USM-Settings ; Update Success"
    bash "$DESKTOP"/Settings.sh
  elif command -v yum &>/dev/null; then
    xterm -e "sudo yum update"
    xterm -e "sudo yum update-minimal"
    zenity --info --title="System Update" --text="USM-Settings ; Update Success"
    bash "$DESKTOP"/Settings.sh
  elif command -v dnf &>/dev/null; then
    xterm -e "sudo dnf update"
    zenity --info --title="System Update" --text="USM-Settings ; Update Success"
    bash "$DESKTOP"/Settings.sh
  elif command -v pacman &>/dev/null; then
    xterm -e "sudo pacman -Syu"
    zenity --info --title="System Update" --text="USM-Settings ; Update Success"
    bash "$DESKTOP"/Settings.sh

  # Unsuccessful Operation
  else

    zenity --info --title="System Update" --text="USM-Settings ; System update could not be carried out as the package manager was not found."
    bash "$(xdg-user-dir DESKTOP)"/Settings.sh
  fi

# Unsuccessful Operation
else

  zenity --info --title="System Update" --text="The update process has been canceled."

fi
