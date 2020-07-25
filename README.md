# telemetry_xiv
This is the telemetry system for msxiv. This project logs data from our vehicle when it is running and stores it. Currently, the project gets CAN Messages/GPS data and uploads it to the cloud.

To install requirements run:
```bash
pip3 install -r requirements.txt to install everything.
```

To set up virtual CAN run:
```bash
sudo modprobe vcan \
&& sudo ip link add dev vcan0 type vcan \
&& sudo ip link set up vcan0
```

To send random CAN messages run:
```bash
python3 mock_can_data.py
```
To read CAN messages, store them in a CSV, and send them to FRED, run:
```bash
python3 aggregate_can_data.py
```
