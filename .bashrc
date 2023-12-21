#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias mkd='mkdir'
alias em='emacs -nw'
alias vi='vim'
alias nv='nvim'
#PS1='\[\e[38;2;208;200;200m\]\u@\h\[\e[0m\]:\[\e[38;2;27;32;33m\]\w\[\e[0m\]\$ '
#PS1='\u@\h \W \$ '
PS1='\u@\h \[\e[1;10m\]$(date "+%H:%M:%S")\[\e[0m\] \W \$ '
EDITOR='nvim'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

