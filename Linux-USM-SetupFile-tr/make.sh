#/!bin/bash

chmod +x USM-ayarlar-programcigi.sh

mkdir ~/USM-S
cp kullanici_sil.sh ~/USM-S
cp kullanici_olustur.sh ~/USM-S
cp opaklik_ayarla.sh ~/USM-S
cp parola_degistir.sh ~/USM-S
cp sistem_guncelleme.sh ~/USM-S
cp USM-ayarlar-programcigi.sh "$(xdg-user-dir DESKTOP)"
cp Finish "$(xdg-user-dir DESKTOP)"

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
elif command -v yum &> /dev/null; then
  sudo yum install zenity
  sudo yum install xterm
elif command -v dnf &> /dev/null; then
  sudo dnf install zenity
  sudo dnf install xterm 
elif command -v pacman &> /dev/null; then
  sudo pacman -S zenity
  sudo pacman -S xterm
else
  echo "USM-Ayarlar ; Paket yükleyicisi bulunamadığı için otamatik Zenity ve xterm paketi kurulamadı Zenity ve xterm paketini kurmanız gerekir."
fi

vim Finish
