#!/bin/bash

CWD=$(pwd)

# config files
rm ~/.profile; ln -sv ${CWD}/config/profile ~/.profile
rm ~/.tmux.conf; ln -sv ${CWD}/config/tmux.conf ~/.tmux.conf
rm ~/.vim; ln -sv ${CWD}/config/vim/devel ~/.vim
#rm ~/.bashrc; ln -sv ${CWD}/config/bashrc ~/.bashrc
#rm ~/.bash_profile; ln -sv ${CWD}/config/bash_profile ~/.bash_profile
#rm ~/.bash_config.sh; ln -sv ${CWD}/config/bash_config.sh ~/.bash_config.sh
rm ~/.conkyrc; ln -sv ${CWD}/config/conkyrc ~/.conkyrc
#rm ~/.Xmodmap; ln -sv ${CWD}/config/Xmodmap ~/.Xmodmap
#rm ~/.XCompose; ln -sv ${CWD}/config/XCompose ~/.XCompose
#rm ~/.config/vifm; ln -sv ${CWD}/config/vifm ~/.config/vifm
rm ~/.config/sakura; ln -sv ${CWD}/config/sakura ~/.config/sakura
rm ~/.config/feh; ln -sv ${CWD}/../common/config/feh ~/.config/feh

# ~/.gitconfig is created separately according to example in config/gitconfig
#ln -s ~/igorba/git/setup/config/gitconfig
#ln -s ~/igorba/git/setup/config/gitignore

function create_link() {
    rm -r $2
    ln -sv $1 $2
}

# scripts
# DEST=~/installs/setup/scripts
# mkdir -p ${DEST}
# create_link "${CWD}/scripts/emacsclient.sh" "${DEST}/emacsclient.sh"
# create_link "${CWD}/scripts/backup.sh" "${DEST}/backup.sh"

# tmux
# DEST=~/installs/setup/tmux
# mkdir -p ${DEST}
# create_link "${CWD}/tmux/tmux_dev.sh" "${DEST}/tmux_dev.sh"
# create_link "${CWD}/tmux/tmux_sysmon.sh" "${DEST}/tmux_sysmon.sh"

# launchers
# DEST=~/installs/setup/launchers
# mkdir -p ${DEST}
# create_link "${CWD}/launchers/sakura_tmux_dev.sh" "${DEST}/sakura_tmux_dev.sh"
# create_link "${CWD}/launchers/sakura_tmux_sysmon.sh" "${DEST}/sakura_tmux_sysmon.sh"
# create_link "${CWD}/launchers/syncthing_start.sh" "${DEST}/syncthing_start.sh"

# desktop
# DEST=~/installs/setup/desktop
# mkdir -p ${DEST}
# create_link "${CWD}/desktop/sakura_tmux_sysmon.desktop" "${DEST}/sakura_tmux_sysmon.desktop"
# create_link "${CWD}/desktop/sakura_tmux_dev.desktop" "${DEST}/sakura_tmux_dev.desktop"
# create_link "${CWD}/desktop/doom2.desktop" "${DEST}/doom2.desktop"
# create_link "${CWD}/desktop/qtcreator.desktop" "${DEST}/qtcreator.desktop"
# create_link "${CWD}/desktop/umlet.desktop" "${DEST}/umlet.desktop"
# create_link "${CWD}/desktop/syncthing.desktop" "${DEST}/syncthing.desktop"
# create_link "${CWD}/desktop/conky.desktop" "${DEST}/conky.desktop"

# add some desktop launchers links to ~/.local/share/applications
DEST1=~/.local/share/applications
create_link "${CWD}/desktop/sakura_tmux_dev.desktop" "${DEST1}/sakura_tmux_dev.desktop"
create_link "${CWD}/desktop/sakura_tmux_sysmon.desktop" "${DEST1}/sakura_tmux_sysmon.desktop"
create_link "${CWD}/desktop/umlet.desktop" "${DEST1}/umlet.desktop"
create_link "${CWD}/desktop/doom2.desktop" "${DEST1}/doom2.desktop"
create_link "${CWD}/desktop/syncthing.desktop" "${DEST1}/syncthing.desktop"
create_link "${CWD}/desktop/conky.desktop" "${DEST1}/conky.desktop"

# add some desktop launchers links to ~/.config/autostart
DEST1=~/.config/autostart
create_link "${CWD}/desktop/syncthing.desktop" "${DEST1}/syncthing.desktop"
create_link "${CWD}/desktop/conky.desktop" "${DEST1}/conky.desktop"
