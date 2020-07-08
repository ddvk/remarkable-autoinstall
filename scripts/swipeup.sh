#!/bin/sh
DRAFT_PID="/tmp/draft"
DRAFT_KILL="/tmp/draft_kill"
if [ -f $DRAFT_PID ]; then
	if [ -f $DRAFT_KILL ]; then
		sh $DRAFT_KILL
		rm $DRAFT_KILL
	fi
    pid=$(cat $DRAFT_PID)
    rm $DRAFT_PID
    kill $pid
    #todo find a better way
    killall chess
    killall fingerterm
    killall plato
    killall edit
    killall draft
    systemctl start xochitl
else
    systemctl stop xochitl
    ~/draft &
    echo $! > $DRAFT_PID
fi
