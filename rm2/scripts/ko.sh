#!/bin/sh
export LC_ALL="en_US.UTF-8"
export KO_DONT_SET_DEPTH=1
export KO_DONT_GRAB_INPUT=1

if [ -z "$NO_XO" ]; then
    systemctl stop xochitl
fi

if [ ! -z "`pidof remarkable-shutdown`"]; then
    killall remarkable-shutdown
fi

LD_PRELOAD=/home/root/librm2fb_server.so.1.0.0 /usr/bin/remarkable-shutdown &
sleep 2

export LD_PRELOAD=/home/root/librm2fb_client.so.1.0.0

# working directory of koreader
KOREADER_DIR="/home/root/apps/koreader"

# we're always starting from our working directory
cd "${KOREADER_DIR}" || exit

# load our own shared libraries if possible
export LD_LIBRARY_PATH="${KOREADER_DIR}/libs:${LD_LIBRARY_PATH}"

# export trained OCR data directory
export TESSDATA_PREFIX="data"

# export dict directory
export STARDICT_DATA_DIR="data/dict"

# export external font directory
export EXT_FONT_DIR="/home/root/ttf;/usr/Share/fonts/ttf;/usr/share/fonts/opentype"

./reader.lua "/home/root"

killall remarkable-shutdown
systemctl reset-failed xochitl
if [ -z "$NO_XO" ]; then
    systemctl start xochitl
fi

