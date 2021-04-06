# telemetry_xiv
[![Build Status](https://travis-ci.com/uw-midsun/telemetry_xiv.svg?branch=master)](https://travis-ci.com/uw-midsun/telemetry_xiv)

This is the telemetry system for msxiv. This project logs data from our vehicle when it is running and stores it. Currently, the project gets CAN Messages/GPS data and writes it to a CSV, FRED, and uploads it to AWS DynamoDB.

Clone this repository on your system.
For the Midsun VM (x86), this should be cloned in the shared folder.
For the RPI, this should be cloned under the desktop.

Make sure you go to https://github.com/uw-midsun/firmware_xiv and run `make codegen_dbc` to generate a DBC file, then move it to the telemetry repo so that the scripts below can run properly.

To install requirements run:
```bash
pip3 install -r requirements.txt
```

To set up virtual CAN run:
```bash
make socketcan
```

To configure the telemetry system to run on startup run:
```bash
chmod +x startup.sh
sudo ./startup.sh
```
Warning: If you have anything in the /etc/rc.local file this will overwrite it

To read CAN messages, store them in a CSV and send them to FRED perform the following:
1. Create a .env file and enter something similar to what is shown below.
```bash
MQTT_CLIENT_ID=my_client_id
MQTT_USERNAME=my_username
MQTT_PASSWORD=my_password
DBC_PATH=/home/vagrant/shared/telemetry_xiv/system_can.dbc
```
2. To run the telemetry system perform:
```bash
# For the Raspberry Pi
make run PLATFORM=rpi
# Alternative for testing
make run PLATFORM=x86
# To kill the scripts
pkill python
```
The scripts below are found in the telemetry scripts file and can be run individually

3. To collect CAN data run:
```bash
python3 aggregate_can_data.py
```
4. To collect GPS data run:
```bash
python3 GPS.py
```
5. To collect CAN data for the driver display run:
```bash
python3 web_aggregate_can_data.py
```
6. To send random CAN messages, generate a DBC file in codegen-tooling-msxiv and move it to telemetry_xiv then run:
```bash
python3 mock_can_data.py
```
