#!/bin/bash

ln -s ~/igorba/git/setup/config/bashrc      ~/.bashrc
ln -s ~/igorba/git/setup/config/profile     ~/.profile
ln -s ~/igorba/git/setup/config/tmux.conf   ~/.tmux.conf
ln -s ~/igorba/git/setup/config/Xmodmap     ~/.Xmodmap
ln -s ~/igorba/git/setup/config/feh         ~/.config/feh
ln -s ~/igorba/git/setup/config/sakura      ~/.config/sakura
ln -s ~/igorba/git/setup/config/vifm        ~/.config/vifm

# ~/.gitconfig is created separately according to example in config/gitconfig
#ln -s ~/igorba/git/setup/config/gitconfig
#ln -s ~/igorba/git/setup/config/gitignore

mkdir -p ~/vim/
ln -s ~/igorba/git/setup/config/vim/basic ~/vim/basic
ln -s ~/igorba/git/setup/config/vim/devel ~/vim/devel
ln -s ~/vim/devel/ ~/.vim
