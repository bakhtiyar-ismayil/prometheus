wget   https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanager-0.21.0.linux-amd64.tar.gz

tar -xzvf alertmanager-0.21.0.linux-amd64.tar.gz

sudo groupadd -f alertmanager
sudo useradd -g alertmanager --no-create-home --shell /bin/false alertmanager
sudo mkdir -p /etc/alertmanager/templates
sudo mkdir /var/lib/alertmanager
sudo chown alertmanager:alertmanager /etc/alertmanager
sudo chown alertmanager:alertmanager /var/lib/alertmanager
sudo cp alertmanager-0.21.0.linux-amd64/alertmanager /usr/bin/
sudo cp alertmanager-0.21.0.linux-amd64/amtool /usr/bin/
sudo chown alertmanager:alertmanager /usr/bin/alertmanager
sudo chown alertmanager:alertmanager /usr/bin/amtool
sudo cp alertmanager-0.21.0.linux-amd64/alertmanager.yml /etc/alertmanager/alertmanager.yml
sudo chown alertmanager:alertmanager /etc/alertmanager/alertmanager.yml

sudo cat << EOF >> /usr/lib/systemd/system/alertmanager.service

[Unit]
Description=AlertManager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/bin/alertmanager \
    --config.file /etc/alertmanager/alertmanager.yml \
    --storage.path /var/lib/alertmanager/

[Install]
WantedBy=multi-user.target

EOF

sudo chmod 664 /usr/lib/systemd/system/alertmanager.service

sudo systemctl daemon-reload
sudo systemctl enable --now  alertmanager
