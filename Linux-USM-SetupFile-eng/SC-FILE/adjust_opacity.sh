#!/bin/bash


# Desktop check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

    DESKTOP="$HOME/Desktop"

    if [ ! -d "$DESKTOP" ]; then

         zenity --info --title="Desktop Error" --text="Desktop directory not found. Change the value of DESKTOP(4) inside the ~/USM-S/adjust_opacity.sh file to indicate your desktop location."

        exit

    fi

fi


# Opacity value
yuzde=$(zenity --entry --title="Opacity" --text="Please enter a value between 100 and 0:")


# Operation
if [ -n "$yuzde" ] && [ "$yuzde" -le 100 ] && [ "$yuzde" -ge 0 ]; then
    xfconf-query -c xfwm4 -p /general/frame_opacity -s "$yuzde"
    zenity --info --title="Successful" --text="Operation Successful"
    bash "$DESKTOP"/Settings.sh

# Unsuccessful operation
else
    zenity --warning --title="Unsuccessful" --text="Please do not leave the box empty or enter an invalid value."
    bash "$DESKTOP"/Settings.sh
fi
