#!/bin/bash


# Erişim sorgulama
QUERY=""

wget -q --spider https://github.com

if [ ! $? -eq 0 ]; then

echo -e "\033[31mHATA: Ağ bağlantısı başarısız olduğu için gerekli paketler yüklenemez. Genede kurulumu sürdürmek için [Y/N]\033[0m" 

read -p "" QUERY

  if [[ $QUERY == "Y" || $QUERY == "y" ]]; then

	 echo ""
  
  else 
  
	 exit

  fi

fi

chmod +x SC-FILE/USM-ayarlar-programcigi.sh


# Masaüstü sorgulama
DESKTOP="$HOME/Masaüstü"

if [ ! -d "$DESKTOP" ]; then

  DESKTOP="$HOME/Desktop"

  if [ ! -d "$DESKTOP" ]; then

    echo -e "\033[31mHATA: Masaüstü dizini bulunamadı Make dosyasının içindeki DESKTOP(7) değer kısmını masaüstü konumunuzu işaretleyecek şekilde değiştirin.\033[0m"

    exit

  fi

fi


# Kurulum sorgulama
if [ -d "$HOME/USM-S" ]; then

  echo -e "\033[31mHATA: USM-Settings daha önce kurulmuş ~/USM-S yolunu kaldırıp tekrar deneyin.\033[0m"

  exit

fi


# Kopyalama işlemleri
mkdir ~/USM-S
cp SC-FILE/kullanici_sil.sh ~/USM-S
cp SC-FILE/kullanici_olustur.sh ~/USM-S
cp SC-FILE/opaklik_ayarla.sh ~/USM-S
cp SC-FILE/parola_degistir.sh ~/USM-S
cp SC-FILE/sistem_guncelleme.sh ~/USM-S
cp SC-FILE/USM-ayarlar-programcigi.sh "$DESKTOP"
cp SC-FILE/Finish "$DESKTOP"


# Yetkilendirme işlemleri
chmod +x ~/USM-S/kullanici_sil.sh
chmod +x ~/USM-S/kullanici_olustur.sh
chmod +x ~/USM-S/opaklik_ayarla.sh
chmod +x ~/USM-S/parola_degistir.sh
chmod +x ~/USM-S/sistem_guncelleme.sh

cd "$DESKTOP" || exit
mv USM-ayarlar-programcigi.sh Ayarlar.sh


# Erişim sorgulama (2)
wget -q --spider https://github.com

if [ ! $? -eq 0 ]; then

	echo -e "\033[31mHATA: İnternete erişim sağlanamadığı için gerekli paketler kurulamadı. El ile zenity, vim ve xterm paketlerini kurmanız gerekir.\033[0m"
	vim finish
	exit

fi


# Paket yükleyicisi sorgulama
if command -v apt &>/dev/null; then
  sudo apt install zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mHATA: bir hata dolayısıyla paketler yüklenemediği için otamatik zenity, vim ve xterm paketleri kurulamadı. Bu paketleri el ile kurmanız gerekir.\033[0m";

  fi

elif command -v yum &>/dev/null; then
  sudo yum install zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mHATA: bir hata dolayısıyla paketler yüklenemediği için otamatik zenity, vim ve xterm paketleri kurulamadı. Bu paketleri el ile kurmanız gerekir.\033[0m";

  fi

elif command -v dnf &>/dev/null; then
  sudo dnf install zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mHATA: bir hata dolayısıyla paketler yüklenemediği için otamatik zenity, vim ve xterm paketleri kurulamadı. Bu paketleri el ile kurmanız gerekir.\033[0m";

  fi

elif command -v pacman &>/dev/null; then
  sudo pacman -S zenity xterm vim

  if ! command -v vim || ! command -v xterm || ! command -v vim ; then

	  echo -e "\033[31mHATA: bir hata dolayısıyla paketler yüklenemediği için otamatik zenity, vim ve xterm paketleri kurulamadı. Bu paketleri el ile kurmanız gerekir.\033[0m";

  fi

else
  echo -e "\033[31mHATA: Paket yükleyicisi bulunamadığı için otamatik zenity, vim ve xterm paketi kurulamadı. Bu paketleri el ile kurmanız gerekir.\033[0m"
  exit
fi

zenity --info --title="Linux-USM-Settings Setup" --text="Kurulum Başarılı"

vim Finish

#Finish
