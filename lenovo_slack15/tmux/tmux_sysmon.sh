#!/bin/bash

# try this instead:
# if ! tmux has-session -t sysmon; then

tmux has-session -t sysmon 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session    -s sysmon       -n top -d
    tmux send-keys      -t sysmon:top   "btop" C-m
#    tmux split-window   -t sysmon:top   -v 
#    tmux send-keys      -t sysmon:top.1 "nload wlan0" C-m
    tmux new-window     -t sysmon       -n root
    tmux send-keys      -t sysmon:root  "clear;su -" C-m
    tmux new-window     -t sysmon       -n util
    tmux send-keys      -t sysmon:util  "clear" C-m
#    tmux new-window     -t sysmon       -n task
#    tmux send-keys      -t sysmon:task  "task next" C-m
#    tmux new-window     -t sysmon       -n lang
#    tmux send-keys      -t sysmon:lang "setxkbmap -layout us,il,ru; setxkbmap -option compose:ralt" C-m

    tmux select-window  -t sysmon:top
    tmux attach         -t sysmon
else
    tmux attach-session -t sysmon
fi
