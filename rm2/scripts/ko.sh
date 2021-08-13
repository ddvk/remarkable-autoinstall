#!/bin/sh

kill-server(){
  if [ -f /tmp/rm2fb-server.pid ];then
    pid=$(cat /tmp/rm2fb-server.pid)
    if kill -s 0 $pid;then
      kill $pid
    fi
    rm /tmp/rm2fb-server.pid
  fi
}

if [ -z "$NO_XO" ]; then
    systemctl stop xochitl
fi

kill-server

LD_PRELOAD=/home/root/librm2fb_server.so.1.0.1 /usr/bin/xochitl &
echo $! > /tmp/rm2fb-server.pid
sleep 2

export KO_DONT_SET_DEPTH=1
export KO_DONT_GRAB_INPUT=1
export LD_PRELOAD=/home/root/librm2fb_client.so.1.0.1

/home/root/apps/koreader/koreader.sh

kill-server

systemctl reset-failed xochitl
if [ -z "$NO_XO" ]; then
    systemctl start xochitl
fi

