#!/bin/bash

DATE=$(date +%Y_%m_%d)

# backup from
SOURCE=$(cd $HOME; pwd)

# backup to
USER=$(whoami)
LINUX_BACKUP="/run/media/$USER/linux/backup/slackware/"
WINSHARE_BACKUP="/run/media/$USER/winshare/backup/"

function backup_user() {
    mkdir -p $LINUX_BACKUP/$USER
    rsync -avz --progress --delete --delete-excluded \
        $SOURCE/Desktop \
        $SOURCE/Downloads \
        $SOURCE/Dropbox \
        $SOURCE/igorba  \
        $SOURCE/installs \
        $SOURCE/tools  \
        $LINUX_BACKUP/$USER/

    mkdir -p $LINUX_BACKUP/$USER/dotfiles/ssh
    cp -rv $SOURCE/.ssh/*       $LINUX_BACKUP/$USER/dotfiles/ssh

    cp -v /etc/fstab            $LINUX_BACKUP/$USER/

    echo $DATE > $LINUX_BACKUP/$USER.backup.time.txt
}

# need to fix this function, as winshare is not ntfs anymore
function backup_winshare() {
    rsync -avz --progress --delete --delete-excluded \
        --exclude=videos    \
        --exclude=tmp       \
        /mnt/Data/winshare   \
        $WINSHARE_BACKUP/

    echo $DATE > $WINSHARE_BACKUP/winshare.backup.time.txt
}

if ! [ -d $LINUX_BACKUP ]; then
    echo "$LINUX_BACKUP not mounted. Exiting"
    exit
fi
backup_user

if ! [ -d $WINSHARE_BACKUP ]; then
    echo "$WINSHARE_BACKUP not mounted. Exiting"
    exit
fi
#backup_winshare

sync

