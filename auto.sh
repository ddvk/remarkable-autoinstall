set -e
APPDIR=/home/root/apps
REPOURL="https://raw.githubusercontent.com/ddvk/remarkable-autoinstall"
mkdir -p $APPDIR
mkdir -p ~/.config/draft
mkdir -p ~/scripts

wget "$REPOURL/master/apps/draft" -O $APPDIR/draft
wget "$REPOURL/master/apps/edit" -O $APPDIR/edit
wget "$REPOURL/master/apps/touchinjector" -O $APPDIR/touchinjector
wget "$REPOURL/master/scripts/swipeup.sh" -O ~/scripts/swipeup.sh
wget "$REPOURL/master/.config/draft/03-edit" -O ~/.config/draft/03-edit

cat << EOF > /etc/systemd/system/touchinjector.service 
[Unit]
Description=touch injector
After=home.mount

[Service]
Environment=HOME=/home/root
ExecStart=$APPDIR/touchinjector
Restart=on-failure
WatchdogSec=60

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start touchinjector
