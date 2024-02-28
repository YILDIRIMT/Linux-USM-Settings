#!/bin/bash

chmod +x SC-FILE/USM-ayarlar-programcigi.sh

# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

    echo -e "\033[31m HATA: Masaüstü dizini bulunamadı Make dosyasının içindeki DESKTOP(7) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin. \033[0m"

    exit

  fi

fi

# Kurulum sorgulama
if [ -d "$HOME/USM-S" ]; then

  echo -e "\033[31m HATA: USM-Settings daha önce kurulmuş ~/USM-S yolunu kaldırıp tekrar deneyin \033[0m"

  exit

fi

# Kopyalama işlemleri
mkdir ~/USM-S
cp SC-FILE/kullanici_sil.sh ~/USM-S
cp SC-FILE/kullanici_olustur.sh ~/USM-S
cp SC-FILE/opaklik_ayarla.sh ~/USM-S
cp SC-FILE/parola_degistir.sh ~/USM-S
cp SC-FILE/sistem_guncelleme.sh ~/USM-S
cp SC-FILE/USM-ayarlar-programcigi.sh "$DESKTOP"
cp SC-FILE/Finish "$DESKTOP"

# Yetkilendirme işlemleri
chmod +x ~/USM-S/kullanici_sil.sh
chmod +x ~/USM-S/kullanici_olustur.sh
chmod +x ~/USM-S/opaklik_ayarla.sh
chmod +x ~/USM-S/parola_degistir.sh
chmod +x ~/USM-S/sistem_guncelleme.sh

cd "$DESKTOP" || exit
mv USM-ayarlar-programcigi.sh Ayarlar.sh

# Paket yükleyicisi sorgulama
if command -v apt &>/dev/null; then
  sudo apt install zenity xterm vim
elif command -v yum &>/dev/null; then
  sudo yum install zenity xterm vim
elif command -v dnf &>/dev/null; then
  sudo dnf install zenity xterm vim
elif command -v pacman &>/dev/null; then
  sudo pacman -S zenity xterm vim
else
  echo -e "\033 HATA: Paket yükleyicisi bulunamadığı için otamatik zenity, vim ve xterm paketi kurulamadı zenity ve xterm paketini kurmanız gerekir. \033[0m"
fi

vim Finish
