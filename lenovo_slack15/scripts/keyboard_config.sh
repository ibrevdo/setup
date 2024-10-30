#!/bin/bash

set -x

# xset -q
xset r rate 600 25

# from: man xkeyboard-config
# setxkbmap -query
setxkbmap -layout us,il,ru -option grp:shifts_toggle,ctrl:nocaps,compose:ralt
