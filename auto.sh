set -e
APPDIR=${APPDIR:-/home/root/apps}
REPOURL="https://raw.githubusercontent.com/ddvk/remarkable-autoinstall"
mkdir -p $APPDIR
mkdir -p ~/.config/draft
mkdir -p ~/scripts
mkdir -p ~/edit

systemctl stop touchinjector || true
echo "Downloading files..."
wget "$REPOURL/master/scripts/swipeup.sh" -O ~/scripts/swipeup.sh

apps=( draft edit touchinjector fingerterm )
for app in "${apps[@]}"
do
    wget "$REPOURL/master/apps/$app" -O $APPDIR/$app
done

echo "Downloading draft configs..."
cfgs=( 03-edit 05-fingerterm )
for cfg in "${cfgs[@]}"
do
    wget "$REPOURL/master/.config/draft/$cfg" -O ~/.config/draft/$cfg
done

echo "Setting exec permissions"
for f in $APPDIR/*; do
    chmod +x $f
done
chmod +x ~/scripts/swipeup.sh

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

systemctl daemon-reload
systemctl enable touchinjector
systemctl start touchinjector
echo "Started touch gestures"
