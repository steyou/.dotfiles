#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias vn='nvim'
alias ..='cd ..'
alias mkd='mkdir'
#PS1='[\u@\h \W]\$ '
PS1='\u@\h \[\e[1;10m\]$(date "+%H:%M:%S")\[\e[0m\] \W \$ '
