#!/bin/bash

# Desktop directory check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

    zenity --info --title="Error Desktop" --text="ERROR: Desktop directory not found. Modify the DESKTOP(5) value in the ~/USM-S/kullanici_sil.sh file to point to your desktop location."

    exit

fi


# Password verification
DATA=$(zenity --forms --title="Delete User" \
    --text="" \
    --add-password="Enter the password of the currently logged-in account : ")

currp=$(awk -F'|' '{print $1}' <<<"$DATA")


# User name entry
if echo "$currp" | sudo -S echo "" >/dev/null 2>&1; then
    DATA=$(zenity --forms --title="Delete User" --text="" --add-entry="Enter the username to be deleted : ")

    # Processing
    if [ -n "$DATA" ]; then
        sudo userdel -r "$DATA"
        zenity --info --title="Delete User" --text="Operation Successful"
        bash "$DESKTOP"/Settings.sh


    # Unsuccessful operation
    else
        zenity --error --title="Error" --text="An issue occurred, the account may not exist."
        bash "$(xdg-user-dir DESKTOP)"/Settings.sh
    fi
else
    zenity --error --title="Error" --text="Incorrect password or operation failed."
    bash "$DESKTOP"/Settings.sh
fi
