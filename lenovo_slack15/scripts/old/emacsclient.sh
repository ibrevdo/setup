
#!/bin/bash

function client_start() {
    emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
    if [ "$?" = "1" ]; then
        echo Starting emacs server
        emacsclient -c -n -a "" "$@"
    else
        emacsclient -n "$@"
    fi
}

case $1 in
    -c)
        #client_start "${@:2}"
        #emacs "${@:2}" &
        emacsclient -c -n -a "" "${@:2}"
        ;;
    -e)
        emacsclient -r -n -a "" "${@:2}"
        ;;
    -s)
        emacsclient -e "(kill-emacs)"
        ;;
    *)
        printf "Use flags:
-c open file in separate frame (start server if needed)
-e open file in existing frame (start server if needed)
-s stop server"
esac
