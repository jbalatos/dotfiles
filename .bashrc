
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Terminal prompt
PS1="\[\033[31m\][\w \A]\[\033[32m\]> \[\033[37m\]"
PS2="  \[\033[32m\]>\[\033[37m\] "

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias cat='bat'
shopt -s autocd
shopt -s cdspell

# Set up NVM
source /usr/share/nvm/init-nvm.sh

# dotfile git alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
# When first cloning / initialising dotfile,  run the following commands :
# config config --local status.showUntrackedFiles no
# config config --global credential.helper store

#pfetch info
export EDITOR=vim
export SHELL="bash"
export PF_INFO="ascii title os kernel bash editor uptime memory palette"
export PF_COL1=4
export PF_COL3=1

pfetch
# fortune -s | cowsay -f tux

# Created by `pipx` on 2023-06-17 19:47:30
export PATH="$PATH:/home/jbalatos/.local/bin"

