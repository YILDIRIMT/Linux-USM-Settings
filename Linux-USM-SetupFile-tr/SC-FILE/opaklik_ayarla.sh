#!/bin/bash


# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

DESKTOP="$HOME/Desktop"

if [ ! -d "$DESKTOP" ]; then 

echo -e "\033[31m HATA: Masaüstü dizini bulunamadı ~/USM-S/opaklik_ayarla.sh dosyasının içindeki DESKTOP(5) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin. \033[0m"

exit

fi

fi


# Opaklık değeri
yuzde=$(zenity --entry --title="Giriş Örneği" --text="Lütfen 100 - 0 arası bir değer girin :")


# İşleme
if [ -n "$yuzde" ] && [ "$yuzde" -le 100 ] && [ "$yuzde" -ge 0 ]; then
    xfconf-query -c xfwm4 -p /general/frame_opacity -s "$yuzde"
    zenity --info --title="Başarılı" --text="İşlem Başarılı"
    bash "$DESKTOP"/Ayarlar.sh


# Başarısız işlem    
else
    zenity --warning --title="Başarısız" --text="Kutucuğu boş bırakmayın veya geçersiz bir değer girmeyin"
    bash "$DESKTOP"/Ayarlar.sh 
fi