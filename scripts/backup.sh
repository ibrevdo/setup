#!/bin/bash

DATE=$(date +%Y_%m_%d)

# backup from
SOURCE=$(cd $HOME; pwd)

# bachup to
USER=$(whoami)
WINSHARE_BACKUP="/run/media/$USER/winshare/backup/"
LINUX_BACKUP="/run/media/$USER/linux/backup/slackware/"


if ! [ -d $WINSHARE_BACKUP ]; then
	echo "$WINSHARE_BACKUP not mounted. Exiting"
	exit
fi

if ! [ -d $LINUX_BACKUP ]; then
	echo "$LINUX_BACKUP not mounted. Exiting"
	exit
fi

rsync -avz --progress --delete --delete-excluded \
    --exclude=video		\
    /mnt/Data/winshare   $WINSHARE_BACKUP/
echo $DATE > $WINSHARE_BACKUP/winshare.backup.time.txt

mkdir -p $LINUX_BACKUP/$USER
rsync -avz --progress --delete --delete-excluded \
    $SOURCE/Desktop $SOURCE/Downloads $SOURCE/installs $SOURCE/igorba $SOURCE/tools  $LINUX_BACKUP/$USER/

mkdir -p $LINUX_BACKUP/$USER/local
rsync -avz $SOURCE/local/bin $SOURCE/local/include $SOURCE/local/lib $LINUX_BACKUP/$USER/local/

mkdir -p $LINUX_BACKUP/$USER/dotfiles
mkdir -p $LINUX_BACKUP/$USER/dotfiles/vim
mkdir -p $LINUX_BACKUP/$USER/dotfiles/ssh
cp -v $SOURCE/.bashrc $LINUX_BACKUP/$USER/dotfiles/bashrc
cp -v $SOURCE/.gitconfig $LINUX_BACKUP/$USER/dotfiles/gitconfig
cp -v $SOURCE/.profile $LINUX_BACKUP/$USER/dotfiles/profile
cp -rv $SOURCE/.ssh/* $LINUX_BACKUP/$USER/dotfiles/ssh
cp -rv $SOURCE/.vim/* $LINUX_BACKUP/$USER/dotfiles/vim

cp -v /etc/fstab $LINUX_BACKUP/$USER/

echo $DATE > $LINUX_BACKUP/$USER.backup.time.txt
sync
