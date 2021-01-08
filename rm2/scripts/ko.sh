#!/bin/sh

if [ -z "$NO_XO" ]; then
    systemctl stop xochitl
fi

if [ ! -z "`pidof remarkable-shutdown`"]; then
    killall remarkable-shutdown
fi

LD_PRELOAD=/home/root/librm2fb_server.so.1.0.0 /usr/bin/remarkable-shutdown &
sleep 2

export KO_DONT_SET_DEPTH=1
export KO_DONT_GRAB_INPUT=1
export LD_PRELOAD=/home/root/librm2fb_client.so.1.0.0

/home/root/apps/koreader/koreader.sh

killall remarkable-shutdown
systemctl reset-failed xochitl
if [ -z "$NO_XO" ]; then
    systemctl start xochitl
fi

