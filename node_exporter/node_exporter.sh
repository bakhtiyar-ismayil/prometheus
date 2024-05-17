chmod 755 /tmp/node_exporter-1.8.0.linux-amd64/node_exporter

mv /tmp/node_exporter-1.8.0.linux-amd64/node_exporter /usr/local/bin/

useradd --system --shell /bin/false node_exporter

chown node_exporter:node_exporter /usr/local/bin/node_exporter

tee /etc/systemd/system/node_exporter.service <<"EOF"

[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

sudo restorecon -rv /usr/local/bin/node_exporter

sudo systemctl daemon-reload 

sudo systemctl enable --now node_exporter
