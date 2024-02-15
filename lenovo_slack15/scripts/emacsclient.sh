
#!/bin/bash

emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
if [ "$?" = "1" ]; then
    echo Server not running
    emacsclient -c -n -a "" "$@"
else
    echo Server running
    emacsclient -n -a "" "$@"
fi
