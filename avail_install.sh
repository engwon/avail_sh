pm2 stop availd && pm2 delete availd
wget "https://raw.githubusercontent.com/engwon/avail_sh/main/config.yml"
mv config.yml ~/avail-light

tee /etc/systemd/system/availd.service > /dev/null << EOF
[Unit]
Description=Avail Light Client
After=network.target
StartLimitIntervalSec=0
[Service]
User=root
ExecStart=/root/avail-light/avail-light --config /root/avail-light/config.yml --app-id 0 --identity /root/avail-light/identity.toml
Restart=always
RestartSec=120
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable availd
sudo systemctl start availd.service
