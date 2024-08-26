#!/bin/bash

DATE=$(date +%Y_%m_%d)

# backup from
SOURCE=$(cd $HOME; pwd)

# backup to
USER=$(whoami)
LINUX_BACKUP="/run/media/$USER/linux/backup/slackware15/"

function backup_user() {
    mkdir -p $LINUX_BACKUP/$USER
    rsync -avz --progress --delete --delete-excluded \
          $SOURCE/Desktop \
          $SOURCE/Dropbox \
          $SOURCE/Downloads \
          $SOURCE/igorba  \
          $SOURCE/installs \
          $LINUX_BACKUP/$USER/

    mkdir -p $LINUX_BACKUP/$USER/dotfiles/ssh
    cp -rv $SOURCE/.ssh/*       $LINUX_BACKUP/$USER/dotfiles/ssh
}

function backup_media() {
    mkdir -p $LINUX_BACKUP/media
    MEDIA_SOURCE=/mnt/igor_media/media
    rsync -avz --progress --delete \
          $MEDIA_SOURCE/books \
          $MEDIA_SOURCE/downloads \
          $MEDIA_SOURCE/music \
          $MEDIA_SOURCE/phone \
          $MEDIA_SOURCE/photos \
        $LINUX_BACKUP/media/
}

function backup_root {
    printf "\nPlease continue with sudo password\n"
    sudo -s -- <<EOF
rsync -avz /etc $LINUX_BACKUP/

mkdir -p $LINUX_BACKUP/root
rsync -avz --delete \
      --exclude=tmp \
      --exclude=local_tmp \
      /root/config /root/installs \
      $LINUX_BACKUP/root/
EOF
}


if ! [ -d $LINUX_BACKUP ]; then
    echo "Is $LINUX_BACKUP mounted?"
    exit
else
    backup_user
    backup_media
    backup_root
    echo $DATE > $LINUX_BACKUP/backup.time.txt
fi

sync
