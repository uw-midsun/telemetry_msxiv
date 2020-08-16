# telemetry_xiv
This is the telemetry system for msxiv. This project logs data from our vehicle when it is running and stores it. Currently, the project gets CAN Messages/GPS data and uploads it to the cloud.

To install requirements run:
```bash
pip3 install -r requirements.txt
```

To set up virtual CAN run:
```bash
sudo modprobe vcan \
&& sudo ip link add dev vcan0 type vcan \
&& sudo ip link set up vcan0
```

To send random CAN messages, generate a DBC file in codegen-tooling-msxiv and move it to telemetry_xiv then run:
```bash
python3 mock_can_data.py
```
To read CAN messages, store them in a CSV and send them to FRED perform the following:
1. Create a .env file and enter something similar to what is shown below.
```bash
MQTT_CLIENT_ID=''
MQTT_USERNAME=''
MQTT_PASSWORD=''
```
2. To collect CAN data run:
```bash
python3 aggregate_can_data.py
```
3. To collect GPS data run:
```bash
python3 GPS.py
```
