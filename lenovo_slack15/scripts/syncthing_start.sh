#!/bin/bash

if pgrep -x syncthing >/dev/null; then
    echo "Syncthing already running"
else
    echo "Starting Syncthing.."
    syncthing -no-browser 1>/dev/null 2>&1 &
    echo "Access Syncthing at http://127.0.0.1:8384"
fi
