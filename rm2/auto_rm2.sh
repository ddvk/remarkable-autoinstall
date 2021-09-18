set -e
APPDIR=${APPDIR:-/home/root/apps}
REPOURL="https://raw.githubusercontent.com/ddvk/remarkable-autoinstall/master/rm2"
RM2FBREPO="https://github.com/ddvk/remarkable2-framebuffer/releases/download/v0.0.6"
KOREADER="https://github.com/koreader/koreader/releases/download/v2021.07/koreader-remarkable-v2021.07.zip"

mkdir -p $APPDIR
mkdir -p ~/scripts

systemctl stop touchinjector || true

echo "Downloading files..."

if [ ! -d "$APPDIR/koreader" ]; then
    mkdir -p "$APPDIR/koreader"
    wget "$KOREADER" -O /tmp/koreader.zip
    unzip /tmp/koreader.zip -d $APPDIR
fi

if [ ! -d "~/librm2fb_client.so.1.0.1" ]; then
    wget "$RM2FBREPO/librm2fb_client.so.1.0.1" -O ~/librm2fb_client.so.1.0.1
fi

if [ ! -d "~/librm2fb_server.so.1.0.1" ]; then
    wget "$RM2FBREPO/librm2fb_server.so.1.0.1" -O ~/librm2fb_server.so.1.0.1
fi
if [ ! -d "~/apps/touchinjector" ]; then
    wget "$REPOURL/apps/touchinjector" -O ~/apps/touchinjector
fi
if [ ! -d "~/scripts/swipeup.sh" ]; then
    wget "$REPOURL/scripts/swipeup.sh" -O ~/scripts/swipeup.sh
fi
if [ ! -d "~/scripts/ko.sh" ]; then
    wget "$REPOURL/scripts/ko.sh" -O ~/scripts/ko.sh
fi
chmod +x ~/scripts/swipeup.sh
chmod +x ~/scripts/ko.sh
chmod +x ~/apps/touchinjector


echo "Systemd unit file"
cat << EOF > /etc/systemd/system/touchinjector.service
[Unit]
Description=touch injector
After=home.mount

[Service]
Environment=HOME=/home/root
ExecStart=$APPDIR/touchinjector

[Install]
WantedBy=multi-user.target
EOF

echo "Starting the touch service..."
systemctl daemon-reload
systemctl enable touchinjector
systemctl start touchinjector

echo "Started touch gestures, you can long swipe up to switch to koreader"
