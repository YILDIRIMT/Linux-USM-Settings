#!/bin/bash

# Araç sorgulama
if ! command -v zenity || command -v xterm || command -v vim; then
  echo -e "Gerekli araçlar kuruluyor"

  if command -v apt &>/dev/null; then
    sudo apt install zenity xterm vim
  elif command -v yum &>/dev/null; then
    sudo yum install zenity xterm vim
  elif command -v dnf &>/dev/null; then
    sudo dnf install zenity xterm vim
  elif command -v pacman &>/dev/null; then
    sudo pacman -S zenity xterm vim
  else
    echo -e "\033 HATA: Paket yükleyicisi bulunamadığı için otamatik zenity, vim ve xterm paketi kurulamadı zenity, vim ve xterm paketini kurmanız gerekir. \033[0m"
  fi

fi

selection=$(zenity --list --title="Ayar Programcığı Seçimi" --text="Aşağıdan bir ayar programcığı seçin:" --column="USM-Ayarlar-Programcığı" "Kullanıcı Oluştur" "Kullanıcı Sil" "Parola Değiştir" "Sistemi Güncelle" "Pencere Opaklığını Ayarla" "XFCE4 Panel Ayarları" "Diğer Ayarlar (XFCE4 Settings)")

case "$selection" in
"Kullanıcı Oluştur")
  bash ~/USM-S/kullanici_olustur.sh
  ;;
"Kullanıcı Sil")
  bash ~/USM-S/kullanici_sil.sh
  ;;
"Parola Değiştir")
  bash ~/USM-S/parola_degistir.sh
  ;;
"Sistemi Güncelle")
  bash ~/USM-S/sistem_guncelleme.sh
  ;;
"Pencere Opaklığını Ayarla")
  bash ~/USM-S/opaklik_ayarla.sh
  ;;
"XFCE4 Panel Ayarları")
  xfce4-panel --preferences
  ;;
"Diğer Ayarlar (XFCE4 Settings)")
  xfce4-settings-manager
  ;;
*) ;;

esac
