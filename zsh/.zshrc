#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


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
# Customize to your needs...
# eval `dircolors ~/LS_COLORS`
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

# XDG Environment Variables
. ~/.config/user-dirs.dirs

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

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export LC_CTYPE=en_US.UTF-8

export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre

# ESP-IDF SDK path
export IDF_PATH="/media/Data/esp/esp-idf"
export PATH="$HOME/.rbenv/bin:$HOME/esp/xtensa-esp32-elf/bin:/opt/genymobile/genymotion/tools:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:/opt/yarn-v1.3.2/bin:$HOME/.yarn/bin:$PATH"
eval "$(rbenv init -)"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh
export WORKON_HOME=~/.virtualenvs
export PIP_VIRTUALENV_BASE=/home/tdtrung17693/.virtualenvs

# fzf color scheme
# Base16 Darktooth
# Author: Jason Milkins (https://github.com/jasonm23)

_gen_fzf_default_opts() {

local color00='#1D2021'
local color01='#32302F'
local color02='#504945'
local color03='#665C54'
local color04='#928374'
local color05='#A89984'
local color06='#D5C4A1'
local color07='#FDF4C1'
local color08='#FB543F'
local color09='#FE8625'
local color0A='#FAC03B'
local color0B='#95C085'
local color0C='#8BA59B'
local color0D='#0D6678'
local color0E='#8F4673'
local color0F='#A87322'

export FZF_DEFAULT_OPTS="
  --height 40% --border
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

}

_gen_fzf_default_opts
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export WINEARCH=wine32
