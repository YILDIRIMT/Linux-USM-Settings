#!/bin/bash


# Desktop directory check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

    zenity --info --title="Error Desktop" --text="ERROR: Desktop directory not found. Modify the DESKTOP(4) value in the ~/USM-S/create_user.sh file to point to your desktop location."

    exit

fi


# Password verification
DATA=$(zenity --forms --title="Create User" \
    --text="" \
    --add-password="Enter the password of the currently logged-in account : ")

currp=$(awk -F'|' '{print $1}' <<<"$DATA")


# New user data entry
if echo "$currp" | sudo -S echo "" >/dev/null 2>&1; then

    DATA=$(zenity --forms --title="Create User" \
        --text="" \
        --add-entry="Enter the new username : " \
        --add-password="Enter the new user password : " \
        --add-password="Enter the new user password again : ")

    # Data distribution
    un=$(awk -F'|' '{print $1}' <<<"$DATA")
    np=$(awk -F'|' '{print $2}' <<<"$DATA")
    conp=$(awk -F'|' '{print $3}' <<<"$DATA")

    if [ -z "$un" ] || [ -z "$np" ]; then
        bash "$DESKTOP"/Settings.sh

    # Processing
    elif [ "$np" = "$conp" ]; then

        sudo useradd -m "$un"

        echo -e "$np\n$np" | sudo passwd "$un"

        zenity --info --title="Create User" --text="Operation Successful"

        bash "$DESKTOP"/Settings.sh

    # Unsuccessful operation
    else
        zenity --error --title="Create User" --text="Passwords do not match"
        bash "$DESKTOP"/Settings.sh
    fi

else
    zenity --error --title="Create User" --text="Password verification failed"
    bash "$DESKTOP"/Settings.sh
fi
