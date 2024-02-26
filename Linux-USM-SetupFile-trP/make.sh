#/!bin/bash

chmod +x SC-FILE/USM-ayarlar-programcigi.sh

mkdir ~/USM-S
cp SC-FILE/kullanici_sil.sh ~/USM-S
cp SC-FILE/kullanici_olustur.sh ~/USM-S
cp SC-FILE/opaklik_ayarla.sh ~/USM-S
cp SC-FILE/parola_degistir.sh ~/USM-S
cp SC-FILE/sistem_guncelleme.sh ~/USM-S
cp SC-FILE/USM-ayarlar-programcigi.sh "$(xdg-user-dir DESKTOP)"
cp SC-FILE/Finish "$(xdg-user-dir DESKTOP)"

chmod +x ~/USM-S/kullanici_sil.sh
chmod +x ~/USM-S/kullanici_olustur.sh
chmod +x ~/USM-S/opaklik_ayarla.sh
chmod +x ~/USM-S/parola_degistir.sh
chmod +x ~/USM-S/sistem_guncelleme.sh


cd "$(xdg-user-dir DESKTOP)"
mv USM-ayarlar-programcigi.sh Ayarlar.sh


if command -v apt &> /dev/null; then
  sudo apt install zenity
  sudo apt install xterm
  sudo apt install vim
elif command -v yum &> /dev/null; then
  sudo yum install zenity
  sudo yum install xterm
  sudo yum install vim
elif command -v dnf &> /dev/null; then
  sudo dnf install zenity
  sudo dnf install xterm
  sudo dnf install vim
elif command -v pacman &> /dev/null; then
  sudo pacman -S zenity
  sudo pacman -S xterm
  sudo pacman -S vim
else
  echo "USM-Ayarlar ; Paket yükleyicisi bulunamadığı için otamatik Zenity ve xterm paketi kurulamadı Zenity ve xterm paketini kurmanız gerekir."
fi

vim Finish