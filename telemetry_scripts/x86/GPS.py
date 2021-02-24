# Note that this version of GPS.py generates random GPS messages
import csv
from dotenv import load_dotenv
from datetime import datetime
import json
import os
import paho.mqtt.client as mqtt
import random
import time

load_dotenv()

broker = "mqtt.sensetecnic.com"
port = 1883
client = mqtt.Client(client_id=os.getenv("MQTT_CLIENT_ID"))
client.username_pw_set(username=os.getenv("MQTT_USERNAME"),
                       password=os.getenv("MQTT_PASSWORD"))

with open('gps_data.csv', 'a', newline='') as csvfile:
    fieldnames = [
        'datetime',
        'latitude',
        'lat_direction',
        'longitude',
        'long_direction',
        'altitude',
        'speed',
        'course']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writerow({
        "datetime": '',
        "latitude": '',
        "lat_direction": '',
        "longitude": '',
        "long_direction": '',
        "altitude": '',
        "speed": '',
        "course": '',
    })
    writer.writeheader()


def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Successfully connected")
    else:
        print("Bad connection returned code=", rc)


def connect():
    client.on_connect = on_connect
    client.connect(broker, port, 60)
    client.loop_start()


def send_gps_data():
    data_dict = {
        "datetime": str(datetime.now()),
        "latitude": round(random.uniform(36, 46), 6),
        "lat_direction": random.choice(['N', 'S']),
        "longitude": round(random.uniform(100, 122), 6),
        "long_direction": random.choice(['E', 'W']),
        "altitude": round(random.uniform(8, 42), 1),
        "speed": round(random.uniform(0, 42), 1),
        "course": round(random.uniform(0, 90), 1),
    }
    write_to_csv(data_dict)
    client.publish(
        "accounts/midnight_sun/GPS",
        payload=json.dumps(data_dict),
        qos=2)


def write_to_csv(data_dict):
    with open('gps_data.csv', 'a', newline='') as csvfile:
        fieldnames = [
            'datetime',
            'latitude',
            'lat_direction',
            'longitude',
            'long_direction',
            'altitude',
            'speed',
            'course']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writerow(data_dict)


def main():
    connect()
    while True:
        send_gps_data()
        time.sleep(3)


if __name__ == "__main__":
    main()
