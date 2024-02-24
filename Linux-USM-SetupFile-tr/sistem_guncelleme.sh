#!/bin/bash


zenity --question --title="Sistem Güncelleme" --text="Sistemi güncellemek istediğinizden emin misiniz?"


  
if [[ $? -eq 0 ]]; then
     
     zenity --info --title="Sistem Güncelleme" --text="Terminale şifrenizi girdikten sonra güncelleme işlemi başlayacak."
     
        if command -v apt &> /dev/null; then
  xterm -e "sudo apt update && upgrade"
  zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
elif command -v yum &> /dev/null; then
  xterm -e "sudo yum update"
  xterm -e "sudo yum update-minimal"
  zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
elif command -v dnf &> /dev/null; then
  xterm -e "sudo dnf update"
  zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
elif command -v pacman &> /dev/null; then
 xterm -e "sudo pacman -Syu"
 zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
 bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
else

  zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Paket yöneticisi bulunamadığı için sistem güncellemesi gerçekleştirilemedi"
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
fi

else
    
    zenity --info --title="Sistem Güncelleme" --text="Güncelleme işlemi iptal edildi."
fi
