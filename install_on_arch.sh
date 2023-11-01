#!bin/env sh

# Throw error if command exits weirdly
set -e 

HELPER="paru"

echo "Hello! Let's this machine up." && sleep 2

# does full system update
echo "Doing a system update, cause stuff may break if it's not the latest version..."
sudo pacman --noconfirm -Syu


echo "###########################################################################"
echo "Fasten your seatbelt!"
echo "###########################################################################"

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git

# choose video driver
echo "1) xf86-video-intel 	2) xf86-video-amdgpu 3) nvidia 4) Skip"
read -r -p "Choose you video card driver(default 1)(will not re-install): " vid

case $vid in 
[1])
	DRI='xf86-video-intel'
	;;

[2])
	DRI='xf86-video-amdgpu'
	;;

[3])
    DRI='nvidia nvidia-settings nvidia-utils'
    ;;

[4])
	DRI=""
	;;
[*])
	DRI='xf86-video-intel'
	;;
esac

# install xorg, picom, and drivers
sudo pacman -S --noconfirm --needed $DRI xorg-server xorg-apps xorg-xinit xorg-xmessage picom \
  libx11 libxft libxinerama libxrandr libxss \
  pkgconf stack

# Other necessary stuff
sudo pacman -S --noconfirm --needed rofi nitrogen kitty lxappearance fish neovim vim nano

if [ ! -d "~/.config" ]; then
  mkdir ~/.config
fi

mkdir ~/.config/xmonad
mkdir ~/.config/xmobar

echo "###########################################################################"
echo "Installing Xmonad Now!"
echo "(also xmobar)"
echo "###########################################################################"

# Install xmonad and xmobar
git clone https://github.com/xmonad/xmonad ~/.config/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib ~/.config/xmonad/xmonad-contrib
git clone https://codeberg.org/xmobar/xmobar ~/.config/xmonad/xmobar

cp ./xmonad/stack.yaml ~/.config/xmonad/stack.yaml
cp ./xmonad/xmonad.hs ~/.config/xmonad/xmonad.hs
cp ./xmonad/xmobar.hs ~/.config/xmobar/xmobar.hs

(cd ~/.config/xmonad && stack install)

(cp ~/.local/bin/xmonad /usr/bin/xmonad)
(cp ~/.local/bin/xmobar /usr/bin/xmobar)
(cp ~/.local/bin/xmonad-contrib /usr/bin/xmonad-contrib)

(cd && cd ./dotfiles)

# Install an AUR helper
echo "We need an AUR helper. It is essential. 1) paru       2) yay"
read -r -p "What is the AUR helper of your choice? (Default is paru): " aurh

if [ $aurh -eq 2 ]
then
    HELPER="yay"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing." 
	git clone https://aur.archlinux.org/$HELPER.git ~/.config/$HELPER
	(cd ~/.config/$HELPER/ && makepkg -si )
fi

# Other tool setups
echo "###########################################################################"
echo "Setting up other stuff(picom, kitty, rofi)!"
echo "###########################################################################"

(cp ./config/rofi/ ~/.config/rofi/ -r)
(cp ./config/kitty/ ~/.config/kitty/ -r)
(cp ./config/picom ~/.config/picom -r)

# Other dotfiles and scripts

(cp ./bashrc ~/.bashrc)
(cp ./gitconfig ~/.gitconfig)

mkdir ~/scripts
cp ./scripts/bright.sh ~/scripts/bright.sh

# Setup neovim
git clone https://github.com/AviAvinav/my-nvim-config ~/.config/nvim/

# Install show-off tools and some other essentials
$HELPER -S --noconfirm --needed flameshot dunst cowsay lolcat sfetch neofetch pfetch figlet eza

# Install fonts
$HELPER -S --noconfirm --needed ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-git
