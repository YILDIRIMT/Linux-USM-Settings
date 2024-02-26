#!/bin/bash



if ! command -v zenity
then
echo -e "Gerekli araçlar kuruluyor..."
sudo pacman -S zenity
fi

zenity --list --title="Resim Seçin" --column="Resim" --icon="/path/to/image.png" "Resim 1" "Resim 2" "Resim 3"


selection=$(zenity --list --title="Ayar Programcığı Seçimi" --text="Aşağıdan bir ayar programcığı seçin:" --column="USM-Ayarlar-Programcığı" "Kullanıcı Oluştur" "Kullanıcı Sil" "Parola Değiştir" "Sistemi Güncelle" "Pencere Opaklığını Ayarla" "XFCE4 Panel Ayarları" "Diğer Ayarlar (XFCE4 Settings)")

case "$selection" in
    "Kullanıcı Oluştur")
        bash ~/USM-S/kullanici_olustur.sh ;;  
    "Kullanıcı Sil")
        bash ~/USM-S/kullanici_sil.sh ;;
    "Parola Değiştir")
        bash ~/USM-S/parola_degistir.sh ;;
    "Sistemi Güncelle")
        bash ~/USM-S/sistem_guncelleme.sh ;;
    "Pencere Opaklığını Ayarla")
        bash ~/USM-S/opaklik_ayarla.sh ;;
    "XFCE4 Panel Ayarları")    
        xfce4-panel --preferences ;;
    "Diğer Ayarlar (XFCE4 Settings)") 
        xfce4-settings-manager ;;
    *)
        
esac
