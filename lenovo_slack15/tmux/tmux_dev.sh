
#!/bin/bash

if ! tmux has-session -t dev 2> /dev/null; then
    tmux new-session    -s dev       -n wiki -d
    tmux send-keys      -t dev:wiki   "clear; cd ${HOME}/igorba/git/wiki" C-m

    tmux new-window     -t dev       -n work
    tmux send-keys      -t dev:work  "clear; cd ${HOME}/igorba/work/leetcode/cpp" C-m

    tmux new-window     -t dev       -n emacs
    tmux send-keys      -t dev:emacs  "clear; cd ${HOME}/.emacs.d/" C-m

    tmux new-window     -t dev       -n python
    tmux send-keys      -t dev:python  "clear; cd ${HOME}/igorba/work/advent/2020" C-m
    tmux split-window   -t dev:python -v
    tmux send-keys      -t dev:python.1  "python3" C-m

    tmux new-window     -t dev       -n deutsch
    tmux send-keys      -t dev:deutsch  "clear; cd ${HOME}/igorba/work/deutsch" C-m

    tmux select-window  -t dev:wiki
    tmux attach-session -t dev
else
    tmux attach-session -t dev
fi
