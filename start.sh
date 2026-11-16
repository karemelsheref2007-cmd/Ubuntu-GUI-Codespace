#!/bin/bash

set -e

mkdir -p ~/.vnc

if [ ! -f ~/.vnc/passwd ]; then
    echo "VNC password not found!"
    echo "Create it using: vncpasswd"
    exit 1
fi

Xtigervnc :1 \
    -geometry 1440x900 \
    -depth 24 \
    -rfbauth ~/.vnc/passwd \
    -localhost \
    &

sleep 3

DISPLAY=:1 dbus-launch --exit-with-session xfce4-session &

sleep 5

websockify \
    --web=/usr/share/novnc \
    6080 \
    localhost:5901
