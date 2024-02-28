#!/bin/bash

# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

    DESKTOP="$HOME/Desktop"

    if [ ! -d "$DESKTOP" ]; then

        echo -e "\033[31m HATA: Masaüstü dizini bulunamadı ~/USM-S/kullanici_sil.sh dosyasının içindeki DESKTOP(5) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin. \033[0m"

        exit

    fi

fi

# Şifre doğrulama
DATA=$(zenity --forms --title="Kullanıcı Sil" \
    --text="" \
    --add-password="Çalışan hesaptaki şifreyi girin : ")

currp=$(awk -F'|' '{print $1}' <<<"$DATA")

# Kullanıcı ismi girişi
if echo "$currp" | sudo -S echo "" >/dev/null 2>&1; then
    DATA=$(zenity --forms --title="Kullanıcı Sil" --text="" --add-entry="Silinicek Kullanıcının Adını girin : ")

    # İşleme
    if [ -n "$DATA" ]; then
        sudo userdel -r "$DATA"
        zenity --info --title="Kullanıcı Sil" --text="İşlem Başarılı"
        bash "$DESKTOP"/Ayarlar.sh

    # Başarısız işlem
    else
        zenity --error --title="Hata" --text="Bir sorun oluştu böyle bir hesap olmayabilir."
        bash "$(xdg-user-dir DESKTOP)"/Ayarlar.sh
    fi
else
    zenity --error --title="Hata" --text="Şifre Yalnış veya işlem başarısız."
    bash "$DESKTOP"/Ayarlar.sh
fi
