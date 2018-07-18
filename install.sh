#!/bin/sh

if [ $UID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi


# Enable necessary copr
COPR=( "yaroslav/i3desktop" "plambri/desktop-apps" "outman/bspwm")

for i in "${COPR[@]}"
do
    dnf copr enable "${i}"
done

# Install lightdm
echo 'Installing lightdm & slick greeter...'
dnf install lightdm slick-greeter
echo 'Done'

# Disable GDM
echo 'Disabling GDM...'
systemctl disable gdm.service
echo 'Done'

# Enable lightdm
echo 'Enabling lighdtm...'
systemctl enable lightdm.service
echo 'Done'

# Install i3-gaps and additional applications
echo 'Installing i3-gaps and additional applications'
dnf install i3-gaps compton feh xbacklight rofi xdotool tlp pavucontrol lemonbar zsh aria2
echo 'Done'

# Install Sublime Text
echo 'Installing Sublime Text 3 Dev...'
dnf config-manager --add-repo https://download.sublimetext.com/rpm/dev/x86_64/sublime-text.repo
dnf install sublime-text
echo 'Done'

# Install zscroll for music player status scrolling text
echo 'Installing zscroll...'
git clone https://github.com/noctuid/zscroll.git /tmp/zscroll

python3 /tmp/zscroll/setup.py install
echo 'Done'

# Install prezto
echo 'Installing prezto...'
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c 'setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done'

rm ~/{.zpreztorc,.zshrc}
echo 'Done'

# Make dotfiles' symlinks
echo 'Installing dotfiles...'
for file in {*} do
    stow "${file}"
done

if [ -d "~/.config/sublime-text-3" ]; then
    pushd "~/.config/sublime-text-3"
    aria2c -x16 -s16 https://packagecontrol.io/Package%20Control.sublime-packagels
    popd
fi
echo 'Done'

    
