#!/bin/bash

# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

    zenity --info --title="Desktop Error" --text="HATA: Masaüstü dizini bulunamadı ~/USM-S/sistem_guncelleme.sh dosyasının içindeki DESKTOP(4) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin."

    exit

  fi

fi

zenity --question --title="Sistem Güncelleme" --text="Sistemi güncellemek istediğinizden emin misiniz?"


if [[ $? -eq 0 ]]; then # 

  zenity --info --title="Sistem Güncelleme" --text="Terminale şifrenizi girdikten sonra güncelleme işlemi başlayacak."

  # İşleme
  # Paket yükleyicisi sorgulama
  if command -v apt &>/dev/null; then
    xterm -e "sudo apt update && upgrade"
    zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
    bash "$DESKTOP"/Ayarlar.sh
  elif command -v yum &>/dev/null; then
    xterm -e "sudo yum update"
    xterm -e "sudo yum update-minimal"
    zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
    bash "$DESKTOP"/Ayarlar.sh
  elif command -v dnf &>/dev/null; then
    xterm -e "sudo dnf update"
    zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
    bash "$DESKTOP"/Ayarlar.sh
  elif command -v pacman &>/dev/null; then
    xterm -e "sudo pacman -Syu"
    zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Güncelleştirme tamamlandı"
    bash "$DESKTOP"/Ayarlar.sh

  # Başarısız İşlem
  else

    zenity --info --title="Sistem Güncelleme" --text="USM-Ayarlar ; Paket yöneticisi bulunamadığı için sistem güncellemesi gerçekleştirilemedi"
    bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh
  fi

# Başarısız İşlem
else

  zenity --info --title="Sistem Güncelleme" --text="Güncelleme işlemi iptal edildi."

fi
