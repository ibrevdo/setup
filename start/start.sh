#!/bin/bash

## Start
if [ $EUID -ne 0 ]; then
	echo 'Please run as root'
	exit
fi

read -p 'Enter current date/time in following format (2021-10-19 12:29): ' dt

## Set system time
# date +'%F %H:%M' -s '2021-12-09 13:01'
date +'%F %H:%M' -s "${dt}"

## Write current time to hwclock
hwclock -w


tmux new-session -n vim -c "~/git/" \;	\
	new-window -n test -c "~/git/" \;	\
	split-window -v \;									\
	last-window
