#!/bin/sh
DRAFT_PID=`pidof ko.sh`
if [ ! -z "$DRAFT_PID" ]; then
    kill -9 -$DRAFT_PID
    systemctl reset-failed xochitl
    systemctl start xochitl
else
    setsid /home/root/scripts/ko.sh &
fi
