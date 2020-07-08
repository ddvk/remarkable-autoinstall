set -e
APPDIR=/home/root/apps
REPOURL="https://raw.githubusercontent.com/ddvk/remarkable-autoinstall"
mkdir -p $APPDIR
mkdir -p ~/.config/draft
mkdir -p ~/scripts
mkdir -p ~/edit

systemctl stop touchinjector || true
echo "Downloading files..."
wget "$REPOURL/master/apps/draft" -O $APPDIR/draft
wget "$REPOURL/master/apps/edit" -O $APPDIR/edit
wget "$REPOURL/master/apps/touchinjector" -O $APPDIR/touchinjector
wget "$REPOURL/master/scripts/swipeup.sh" -O ~/scripts/swipeup.sh
wget "$REPOURL/master/.config/draft/03-edit" -O ~/.config/draft/03-edit

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
