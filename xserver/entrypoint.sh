#!/bin/bash

# Start dbus
rm -rf /var/run/dbus
dbus-uuidgen | tee /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

nohup Xorg "${DISPLAY}" -noreset -dpi 96 -novtswitch +extension MIT-SHM +extension GLX +extension RANDR +extension RENDER -config /etc/X11/xorg.conf &
nohup x11vnc -forever &
tail -n 1000 -F /var/log/Xorg."${DISPLAY/:/}".log
