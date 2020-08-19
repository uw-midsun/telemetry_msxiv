#!/bin/bash

# Create service file to run fan_control.py on startup

# This can be called from any directory to start the service as long as 
# fan_control.py is in the same directory.
FILE_PATH=/etc/systemd/system/fan_control.service

# Remove file if it exists
if test -f "$FILE_PATH"; then
    sudo rm -r $FILE_PATH
fi 

sudo tee -a $FILE_PATH > /dev/null << EOT
[Unit]
Description=Fan Control
After=network.target

[Service]
ExecStart=/usr/bin/python3 ${PWD}/fan_control.py
WorkingDirectory=${PWD} 
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target 
EOT

sudo systemctl enable fan_control.service
sudo systemctl start fan_control.service

