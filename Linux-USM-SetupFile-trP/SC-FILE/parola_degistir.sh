#!/bin/bash


DATA=$(zenity --forms --title="Şifre Değiştir" \
              --text="" \
              --add-password="Çalışan hesaptaki şifreyi girin : " \
              --add-password="Yeni Şifre : " \
              --add-password="Yeni Şifreyi Tekrar girin : ")

if [ $? -ne 0 ] || [ -z "$DATA" ]; then
  zenity --info --text="İşlem iptal edildi"
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh  
fi


P_O=$(echo "$DATA" | awk -F '|' '{print $1}')
P_W=$(echo "$DATA" | awk -F '|' '{print $2}')
P_N_C=$(echo "$DATA" | awk -F '|' '{print $3}')

if [ "$P_W" != "$P_N_C" ]; then
  zenity --error --text="Yeni şifreler uyuşmuyor."
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
fi

echo -e "$P_O\n$P_W\n$P_W" | passwd > /dev/null 2>&1

if [ $? -eq 0 ]; then
  zenity --info --text="Şifre başarıyla güncellendi."
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
else
  zenity --error --text="İşlem başarısız oldu."
  bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
fi 
