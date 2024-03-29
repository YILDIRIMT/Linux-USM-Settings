#!/bin/bash

# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

    zenity --info --title="Desktop Error" --text="HATA: Masaüstü dizini bulunamadı ~/USM-S/parola_degistir.sh dosyasının içindeki DESKTOP(4) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin."

    exit

  fi

fi

# Kullanıcı şifre doğrulama ve yeni veri alma
DATA=$(zenity --forms --title="Şifre Değiştir" \
  --text="" \
  --add-password="Çalışan hesaptaki şifreyi girin : " \
  --add-password="Yeni Şifre : " \
  --add-password="Yeni Şifreyi Tekrar girin : ")

if [ $? -ne 0 ] || [ -z "$DATA" ]; then # "$?" yerine başka bir şey kullanılması gerekiyor Bknz: https://www.shellcheck.net/wiki/SC2181
  zenity --info --text="İşlem iptal edildi"
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh
fi

# Veri dağıtma
P_O=$(echo "$DATA" | awk -F '|' '{print $1}')
P_W=$(echo "$DATA" | awk -F '|' '{print $2}')
P_N_C=$(echo "$DATA" | awk -F '|' '{print $3}')

# Şifre doğrulama
if [ "$P_W" != "$P_N_C" ]; then
  zenity --error --text="Yeni şifreler uyuşmuyor."
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh
fi

# İşleme
echo -e "$P_O\n$P_W\n$P_W" | passwd >/dev/null 2>&1

if [ $? -eq 0 ]; then # "$?" yerine başka bir şey kullanılması gerekiyor Bknz: https://www.shellcheck.net/wiki/SC2181
  zenity --info --text="Şifre başarıyla güncellendi."
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh

# Başarısız işlem
else
  zenity --error --text="İşlem başarısız oldu."
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh
fi
