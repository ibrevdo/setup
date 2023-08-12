#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# add some handy aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

alias python='python3'
alias pydoc='pydoc3'
alias tt='taskwarrior-tui'

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

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

#if [ -d "${IGOR_SETUP_DIR}" ]; then
#	export IGOR_CONFIG_DIR=${IGOR_SETUP_DIR}/config

#	[ -f ~/.tmux.conf ] || ln -s "${IGOR_CONFIG_DIR}"/tmux.conf ~/.tmux.conf
#	[ -d ~/.vim ] || ln -s "${IGOR_CONFIG_DIR}"/vim ~/.vim

#    if [ -f ~/.fzf.bash ]; then
#        export FZF_DEFAULT_OPTS="
#--no-mouse
#--height 50% -1 --reverse --multi --inline-info
#--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
#--bind='?:toggle-preview'
#--bind='ctrl-a:select-all+accept'
#--bind='ctrl-y:execute-silent(echo {+} | pbcopy)'
#--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
#        "
##--preview-window='right:hidden:wrap'
#        #export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
#        FD_OPTIONS="--follow --exclude .git --exclude node_modules"
#        # Use git-ls-files inside git repo, otherwise fd
#        export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
#        export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
#        export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
#    fi
#    export BAT_PAGER="less -R"

#else
#	export IGOR_CONFIG_DIR=~
#fi

#alias wiki_update='(cd ~/work/notes; python3 to_html.py )'

alias vimb='vim --clean -u ~/vim/basic/vimrc -i ~/vim/basic/.viminfo'
alias vimd='vim --clean -u ~/vim/devel/vimrc -i ~/vim/devel/.viminfo'

parse_git_branch() {
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

