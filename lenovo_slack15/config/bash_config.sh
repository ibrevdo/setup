#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# add some handy aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='command diff --color=auto'
fi

if [ -n "$INSIDE_EMACS" ]
then
    export TERM=ansi
    export PAGER=cat
    export MANPAGER=cat
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

#export TERM=xterm-256color
#export TERM=screen-256color

#so that less will use colored search and not italics
export LESS_TERMCAP_se=$'\E[39;49m'
export LESS_TERMCAP_so=$'\E[30;43m'

# disable Ctrl-q/Ctrl-s in shell (unless execution of non-interactive shell)
if [[ -t 0 && $- = *i* ]]; then
    stty -ixon
fi

export PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]\n$ "

#alias vimb='vim --clean -u ~/vim/basic/vimrc -i ~/vim/basic/.viminfo'
#alias vimd='vim --clean -u ~/vim/devel/vimrc -i ~/vim/devel/.viminfo'

#alias e='emacs -nw -q -l ~/.emacs.1.d/init.el'
#alias em='emacs -q --load $(ls ~/emacs_config | fzf)/init.el'

alias e='emacs -nw'
alias ex='emacsclient.sh -c' # use these to run gui emacs with server
alias es='emacsclient.sh -s'

function parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function g {
    if [ -z $(gvim --serverlist) ]; then
        gvim $@ >/dev/null 2>&1
    else
        [ $# -gt 0 ] \
		&& gvim --remote-silent $@ \
		|| gvim --remote-send ':sil call foreground()<CR>'
    fi
}

function create_cpp_proj {
    if [ -f .ccls ]; then
        echo ".ccls already exists"
        return 1
    fi

    cat <<- EOF > .ccls
clang
% -std=c++14
%h -x
% c++-header
EOF

}

