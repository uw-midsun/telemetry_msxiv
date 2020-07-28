# telemetry_xiv
This is the telemetry system for msxiv. This project logs data from our vehicle when it is running and stores it. Currently, the project gets CAN Messages/GPS data and uploads it to the cloud.

To install requirements run:
```bash
pip install -r requirements.txt
```

To set up virtual CAN run:
```bash
sudo modprobe vcan \
&& sudo ip link add dev vcan0 type vcan \
&& sudo ip link set up vcan0
```

To send random CAN messages, generate a DBC file in codegen-tooling-msxiv and move it to telemetry_xiv then run:
```bash
python mock_can_data.py
```
To read CAN messages, store them in a CSV, send them to FRED, and send them to MongoDB Atlas perform the following:
1. Set up MongoDB connection key to connect to the database. Create a .env file and enter something similar to what is shown below.
If you don't have MongoDB Atlas set up, go to https://www.mongodb.com/
```bash
MONGODBKEY=mongodb://localhost:27017/
```
2. Run
```bash
python aggregate_can_data.py
```
