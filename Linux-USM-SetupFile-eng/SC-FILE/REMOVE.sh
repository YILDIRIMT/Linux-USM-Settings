#!/bin/bash


# Desktop check
DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then

    DESKTOP="$HOME/Desktop"

    if [ ! -d "$DESKTOP" ]; then

        zenity --info --title="Desktop Error" --text="ERROR: Desktop directory not found. Modify the DESKTOP(5) value in the USMRemove.sh file to point to your desktop location."

        exit

    fi

fi


# Installation check
if [ ! -d "$HOME/USM-S" ]; then

	zenity --info --text="Not found USM-Settings"
	exit

fi


# Package installer check
PACK=""

if command -v apt &>/dev/null; then

	PACK="apt remove"

elif command -v yum &>/dev/null; then

	PACK="yum remove"

elif command -v dnf &>/dev/null; then

	PACK="dnf remove"

elif command -v pacman &>/dev/null; then

	PACK="pacman -Rns"

else

	zenity --info --text="Not found package manager"

fi


# Operations
selection=$(zenity --list --title="USM Settings Script" --text="" --column="Select;" "All File Delete" "Delete (Just Source File)")


case "$selection" in
"All File Delete")
 rm ~/USM-S/change_pass.sh
 rm ~/USM-S/system_update.sh
 rm ~/USM-S/adjust_opacity.sh
 rm ~/USM-S/create_user.sh
 rm ~/USM-S/delete_user.sh
 rmdir ~/USM-S

 rm $DESKTOP/Settings.sh

 if [ ! -d "$HOME/USM-S" ]; then

	zenity --info --text="The source files have been successfully removed. Enter your password in the terminal window that opens to uninstall dependencies. Afterward, confirm both processes."
	sudo $PACK xterm
        sudo $PACK zenity
 else

        zenity --info --text="For some reason, the source files could not be deleted. You can manually remove the source files from the ~/USM-S location."

 fi



 ;;
 "Delete (Just Source File)")
 rm ~/USM-S/change_pass.sh
 rm ~/USM-S/system_update.sh
 rm ~/USM-S/opaklik_ayarla.sh
 rm ~/USM-S/create_user.sh
 rm ~/USM-S/delete_user.sh
 rmdir ~/USM-S

 rm $DESKTOP/Settings.sh

 if [ ! -d "$HOME/USM-S" ]; then

	 zenity --info --text="The source files have been successfully removed."

 else

        zenity --info --text="For some reason, the source files could not be deleted. You can manually remove the source files from the ~/USM-S location."

 fi


 ;;
*) ;;
esac


#Finish
