#!/bin/bash


# Network connection check
QUERY=""

wget -q --spider https://github.com

if [ ! $? -eq 0 ]; then

echo -e "\033[31mERROR: Necessary packages cannot be installed due to a failed network connection. Continue installation anyway [Y/N]\033[0m" 

read -p "" QUERY

  if [[ $QUERY == "Y" || $QUERY == "y" ]]; then

	 echo ""
  
  else 
  
	 exit

  fi

fi

chmod +x SC-FILE/USM-settings-script.sh


# Desktop check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

    echo -e "\033[31mERROR: Desktop directory not found. Modify the DESKTOP(7) value in the Makefile to point to your desktop location.\033[0m"

    exit

  fi

fi


# Installation check
if [ -d "$HOME/USM-S" ]; then

  echo -e "\033[31mERROR: USM-Settings has been installed before. Remove the ~/USM-S directory and try again.\033[0m"

  exit

fi


# Copy operations
mkdir ~/USM-S
cp SC-FILE/delete_user.sh ~/USM-S
cp SC-FILE/create_user.sh ~/USM-S
cp SC-FILE/adjust_opacity.sh ~/USM-S
cp SC-FILE/change_pass.sh ~/USM-S
cp SC-FILE/system_update.sh ~/USM-S
cp SC-FILE/USM-settings-script.sh "$DESKTOP"
cp SC-FILE/Finish "$DESKTOP"
cp SC-FILE/REMOVE.sh "$DESKTOP"


# Authorization operations
chmod +x ~/USM-S/delete_user.sh.sh
chmod +x ~/USM-S/create_user.sh
chmod +x ~/USM-S/adjust_opacity.sh
chmod +x ~/USM-S/change_pass.sh
chmod +x ~/USM-S/system_update.sh
chmod +x "$DESKTOP"/REMOVE.sh

cd "$DESKTOP" || exit
mv USM-settings-script.sh Settings.sh
mv REMOVE.sh USMRemove.sh


# Network connection check (2)
wget -q --spider https://github.com

if [ ! $? -eq 0 ]; then

	echo -e "\033[31mERROR: Internet access not available. Manually install zenity, vim, and xterm packages.\033[0m"
	vim finish
	exit

fi


# Package installer check
if command -v apt &>/dev/null; then
  sudo apt install zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mERROR: Packages zenity, vim, and xterm could not be automatically installed due to an error. Manually install these packages.\033[0m"

  fi

elif command -v yum &>/dev/null; then
  sudo yum install zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mERROR: Packages zenity, vim, and xterm could not be automatically installed due to an error. Manually install these packages.\033[0m"

  fi

elif command -v dnf &>/dev/null; then
  sudo dnf install zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mERROR: Packages zenity, vim, and xterm could not be automatically installed due to an error. Manually install these packages.\033[0m"

  fi

elif command -v pacman &>/dev/null; then
  sudo pacman -S zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mERROR: Packages zenity, vim, and xterm could not be automatically installed due to an error. Manually install these packages.\033[0m"

  fi

else
  echo -e "\033[31mERROR: Package installer not found. Manually install zenity, vim, and xterm packages.\033[0m"
  exit
fi

zenity --info --title="Linux-USM-Settings Setup" --text="Installation Successful"

vim Finish


#Finish