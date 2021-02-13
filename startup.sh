#!/bin/bash
printf "#!/bin/sh -e
# This sets up the virtual CAN interface and runs aggregate_can_data.py
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0
(sleep 20;python3 /home/pi/box/telemetry_xiv/telemetry_scripts/aggregate_can_data.py)&
(sleep 20;python3 /home/pi/box/telemetry_xiv/telemetry_scripts/GPS.py)&
(sleep 20;python3 /home/pi/box/telemetry_xiv/telemetry_scripts/web_aggregate_can_data.py)&
exit 0

" > /etc/rc.local

sudo chmod +x /etc/rc.local
