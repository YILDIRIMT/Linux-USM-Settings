#!/bin/bash


# Desktop check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

     zenity --info --title="Desktop Error" --text="ERROR: Desktop directory not found. Modify the DESKTOP(4) value in the ~/USM-S/change_pass.sh file to point to your desktop location."

    exit

  fi

fi


# User Password Verification and Retrieving New Data
DATA=$(zenity --forms --title="Change Password" \
  --text="" \
  --add-password="Enter the password of the currently logged-in account:" \
  --add-password="New Password : " \
  --add-password="Enter New Password Again : ")

if [ $? -ne 0 ] || [ -z "$DATA" ]; then
  zenity --info --text="The operation has been canceled."
  bash "$(xdg-user-dir DESKTOP)"/Settings.sh
fi

# Data Distribution
P_O=$(echo "$DATA" | awk -F '|' '{print $1}')
P_W=$(echo "$DATA" | awk -F '|' '{print $2}')
P_N_C=$(echo "$DATA" | awk -F '|' '{print $3}')

# Password Verify
if [ "$P_W" != "$P_N_C" ]; then
  zenity --error --text="Verify Error."
  bash "$(xdg-user-dir DESKTOP)"/Settings.sh
fi


# Operation
echo -e "$P_O\n$P_W\n$P_W" | passwd >/dev/null 2>&1

if [ $? -eq 0 ]; then
  zenity --info --text="Password Change Success"
  bash "$(xdg-user-dir DESKTOP)"/Settings.sh

# Unsuccessful Operation
else
  zenity --error --text="Unsuccessful Operation"
  bash "$(xdg-user-dir DESKTOP)"/Settings.sh
fi

# Finish
