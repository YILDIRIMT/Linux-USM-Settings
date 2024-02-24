#!/bin/bash

yuzde=$(zenity --entry --title="Giriş Örneği" --text="Lütfen 100 - 0 arası bir değer girin :")

if [ -n "$yuzde" ] && [ "$yuzde" -le 100 ] && [ "$yuzde" -ge 0 ]; then
    xfconf-query -c xfwm4 -p /general/frame_opacity -s "$yuzde"
    zenity --info --title="Başarılı" --text="İşlem Başarılı"
    bash woa.sh
else
    zenity --warning --title="Başarısız" --text="Kutucuğu boş bırakmayın veya geçersiz bir değer girmeyin"
    bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh 
fi
