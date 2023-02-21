#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=devel

# Start the session and window 0 in project dir
#   This will also be the default cwd for new windows created
#   via a binding unless overridden with default-path.
#tmux new-session -s "$sn" -n 'work' -d

cd
tmux new-session -s "$sn" -d
#tmux new-window

cd /home/mago/igorba/work/cpp/courses/ida.liu.se_tddd38/02_Classes_and_Operator_Overloading/lab2_Time/
zathura time.pdf &
tmux new-window -t "$sn:2" -n 'work'
tmux split-window -v

cd /home/mago/igorba/git/wiki
tmux new-window -t "$sn:3" -n 'wiki'

cd /home/mago/igorba/git/setup/config/vim/medium
tmux new-window -t "$sn:4" -n 'vim_config'

# send clear to all windows
# C-m means, send enter after the command
tmux send-keys -t $sn:1 clear C-m
tmux send-keys -t $sn:2.0 clear C-m
tmux send-keys -t $sn:2.1 clear C-m
tmux send-keys -t $sn:3 clear C-m
tmux send-keys -t $sn:4.0 clear C-m
# tmux send-keys -t $sn:4.1 clear C-m

cd /home/mago/igorba/work/python/stepik/
tmux new-window -t "$sn:5" -n 'conda'
tmux split-window -v 
tmux send-keys -t $sn:5.0 'clear; source ~/.conda.bash; jupyter notebook' C-m
tmux send-keys -t $sn:5.1 'clear; source ~/.conda.bash' C-m

cd
# tmux new-window -t "$sn:6" -n 'top' 'top'
# tmux split-window -v 'nload wlan0'
tmux new-window -t "$sn:6" -n 'top' 'nload wlan0'
tmux split-window -v
tmux send-keys -t $sn:6.2 'clear; setxkbmap -layout us,ru' C-m

# Select window #1 and attach to the session
tmux select-window -t "$sn:1"
tmux -2 attach-session -t "$sn"
