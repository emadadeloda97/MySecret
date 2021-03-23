#! /bin/bash
printf "\nInstalling the server, please wait..." >&2
{
sudo useradd -m oda1
sudo adduser oda1 sudo
echo oda1:oda | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
sudo apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 
sudo adduser oda1 chrome-remote-desktop
} &> /dev/null &&
su - oda1 -c DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AY0e-g7D79kvZ7FHE-Nn1AEONkUGwGm6qFkOMiggFNSWPDa-SrnDUJCF6bCXDy6sGYnWmg" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)
printf 'Please check https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\nPackage upgrade has completed. " >&2
else
    printf "\n\nAn error has occured " >&2
fi
