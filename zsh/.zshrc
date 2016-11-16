#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P01d2021
  \e]P1cd4533
  \e]P2789b6b
  \e]P3d2a131
  \e]P403829d
  \e]P5a76a7b
  \e]P680988f
  \e]P7a89984
  \e]P8596265
  \e]P9fb543f
  \e]PA95c085
  \e]PBfac33b
  \e]PC048da9
  \e]PDd3869b
  \e]PE8ba59b
  \e]PFfdf4c1
  "
  # get rid of artifacts
  clear
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# eval `dircolors ~/LS_COLORS`
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

# XDG Environment Variables
. ~/.config/user-dirs.dirs

#[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
#source /usr/share/nvm/nvm.sh
#source /usr/share/nvm/bash_completion
#source /usr/share/nvm/install-nvm-exec

# Less clear screen after quit
export LESS="+X"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# allow redirect to work with existed file
setopt clobber

# Navigate through zsh history with arrow btn
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Bind key for termite
bindkey "^[OA" up-line-or-beginning-search # Up
bindkey "^[OB" down-line-or-beginning-search # Down
# Bind key for Urxvt
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Fix for duplicate characters when ssh to another host that unsupport current term info with syntax highlighted shell

alias ssh="TERM=xterm-256color ssh"
eval $(dircolors -b $HOME/.dircolors)

export NVM_DIR="/home/tdtrung17693/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export LC_CTYPE=en_US.UTF-8

export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
