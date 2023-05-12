#!/bin/sh

if [ $UID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi


# Distro: Fedora DNF

# Enable necessary copr
# Install lightdm
echo "Installing lightdm & slick greeter..."
dnf install lightdm slick-greeter
echo "Installed lightdm & slick greeter."

# Install miscellaneous applications
echo "Installing miscellaneous applications..."
dnf install -y neovim git zsh tmux \
  stow lxappearance xclip nitrogen \
  xbacklight rofi xdotool tlp pavucontrol aria2 \
  flameshot
echo "Installed miscellaneous applications."

# Enable lightdm
echo "Enabling lighdtm..."
systemctl enable lightdm.service
echo "Enabled lighdtm."

# Install prezto
echo "Installing prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c "setopt EXTENDED_GLOB"
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
rm ~/{.zpreztorc,.zshrc}
echo "Installed prezto."

echo "Installing tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Installed tpm."

# Make dotfiles' symlinks
echo "Installing dotfiles..."
for file in * do
    stow $file
done

echo "Done"

    
