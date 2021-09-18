#!/bin/sh

if [ -z "$NO_XO" ]; then
    systemctl stop xochitl
fi

if [ ! -z "`pidof rm2fb-server`"]; then
    killall rm2fb-server
fi

LD_PRELOAD=/home/root/librm2fb_server.so.1.0.1 /usr/bin/xochitl &
sleep 2

export KO_DONT_SET_DEPTH=1
export KO_DONT_GRAB_INPUT=1
export LD_PRELOAD=/home/root/librm2fb_client.so.1.0.1

/home/root/apps/koreader/koreader.sh

killall rm2fb-server

systemctl reset-failed xochitl
if [ -z "$NO_XO" ]; then
    systemctl start xochitl
fi

