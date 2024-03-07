#!/bin/bash


#Desktop sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

    DESKTOP="$HOME/Desktop"

    if [ ! -d "$DESKTOP" ]; then

        echo -e "\033[31mHATA: Masaüstü dizini bulunamadı USMKaldır.sh dosyasının içindeki DESKTOP(5) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin. \033[0m"

        exit

    fi

fi


#Kurulum sorgulaması
if [ ! -d "$HOME/USM-S" ]; then

	zenity --info --text="USM Settings cihazınızda bulunamadı"
	exit

fi


#Paket Yöneticisi Bulma
PACK=""

if command -v apt &>/dev/null; then

	PACK="apt remove"
  
elif command -v yum &>/dev/null; then

	PACK="yum remove"
  
elif command -v dnf &>/dev/null; then

	PACK="dnf remove"
  
elif command -v pacman &>/dev/null; then

	PACK="pacman -Rns"
  
else

	zenity --info --text="Yükleyici paketi bulunamadığı için bağımlılıklar silinemiyor"

fi


#İşleme
selection=$(zenity --list --title="USM Ayarlar Programcığı Kaldırma" --text="" --column="Seçim;" "Paketler Dahil Herşeyi Kaldır" "Kaldır (Sadece Kaynak Dosyaları)")


case "$selection" in
"Paketler Dahil Herşeyi Kaldır")
 rm ~/USM-S/parola_degistir.sh 
 rm ~/USM-S/sistem_guncelleme.sh 
 rm ~/USM-S/opaklik_ayarla.sh 
 rm ~/USM-S/kullanici_olustur.sh
 rm ~/USM-S/kullanici_sil.sh
 rmdir ~/USM-S 

 rm $DESKTOP/Ayarlar.sh

 if [ ! -d "$HOME/USM-S" ]; then

	zenity --info --text="Kaynak dosyaları başarılı bir şekilde kaldırıldı. Bağımlılıkların kaldırılması için açılan terminal penceresine parola girişi yapın. Sonrasında 2 işlemide onaylayın"
	sudo $PACK xterm
        sudo $PACK zenity
 else
	 
        zenity --info --text="Bir sebepten ötürü kaynak dosyalar silinemedi. El ile ~/USM-S konumundan kaynak dosyaları kaldırabilirsiniz."

 fi
 


 ;;
 "Kaldır (Sadece Kaynak Dosyaları)")
 rm ~/USM-S/parola_degistir.sh 
 rm ~/USM-S/sistem_guncelleme.sh 
 rm ~/USM-S/opaklik_ayarla.sh 
 rm ~/USM-S/kullanici_olustur.sh
 rm ~/USM-S/kullanici_sil.sh
 rmdir ~/USM-S

 rm $DESKTOP/Ayarlar.sh

 if [ ! -d "$HOME/USM-S" ]; then

	 zenity --info --text="Kaynak dosyaları başarılı bir şekilde kaldırıldı."

 else
	 
        zenity --info --text="Bir sebepten ötürü kaynak dosyalar silinemedi. El ile ~/USM-S konumundan kaynak dosyaları kaldırabilirsiniz."

 fi

 
 ;;
*) ;;
esac


#Finish
