#!/bin/bash

# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

    DESKTOP="$HOME/Desktop"

    if [ ! -d "$DESKTOP" ]; then

         zenity --info --title="Desktop Error" --text="HATA: Masaüstü dizini bulunamadı ~/USM-S/kullanici_olustur.sh dosyasının içindeki DESKTOP(4) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin."

        exit

    fi

fi

# Şifre doğrulama
DATA=$(zenity --forms --title="Kullanıcı oluştur" \
    --text="" \
    --add-password="Çalışan hesaptaki şifreyi girin : ")

currp=$(awk -F'|' '{print $1}' <<<"$DATA")

# Yeni kullanıcı verileri girişi
if echo "$currp" | sudo -S echo "" >/dev/null 2>&1; then

    DATA=$(zenity --forms --title="Kullanıcı oluştur" \
        --text="" \
        --add-entry="Yeni kullanıcı adı : " \
        --add-password="Yeni kullanıcı şifresi : " \
        --add-password="Yeni kullanıcı şifresini tekrar girin : ")

    # Veri dağıtma
    un=$(awk -F'|' '{print $1}' <<<"$DATA")
    np=$(awk -F'|' '{print $2}' <<<"$DATA")
    conp=$(awk -F'|' '{print $3}' <<<"$DATA")

    if [ -z "$un" ] || [ -z "$np" ]; then
        bash "$DESKTOP"/Ayarlar.sh

    # İşleme
    elif [ "$np" = "$conp" ]; then

        sudo useradd -m "$un"

        echo -e "$np\n$np" | sudo passwd "$un"

        zenity --info --title="Kullanıcı oluştur" --text="İşlem Başarılı"

        bash "$DESKTOP"/Ayarlar.sh

    # Başarısız işlem
    else
        zenity --error --title="Kullanıcı oluştur" --text="Şifreler Eşleşmiyor"
        bash "$DESKTOP"/Ayarlar.sh
    fi

else
    zenity --error --title="Kullanıcı oluştur" --text="Şifre Doğrulanamadı"
    bash "$DESKTOP"/Ayarlar.sh
fi
