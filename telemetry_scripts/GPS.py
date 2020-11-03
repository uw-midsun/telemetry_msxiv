import boto3
import csv
from dotenv import load_dotenv
import json
import os
import paho.mqtt.client as mqtt
import RPi.GPIO as GPIO
import serial
import time

load_dotenv()

ser = serial.Serial('/dev/ttyS0', 115200)
ser.flushInput()

broker = "mqtt.sensetecnic.com"
port = 1883
client = mqtt.Client(client_id=os.getenv("MQTT_CLIENT_ID"))
client.username_pw_set(username=os.getenv("MQTT_USERNAME"),
                       password=os.getenv("MQTT_PASSWORD"))

dynamodb = boto3.resource('dynamodb')
dynamo_db_table = dynamodb.Table('gps_data')

power_key = 6
rec_buff = ''
rec_buff2 = ''
time_count = 0

with open('gps_data.csv', 'a', newline='') as csvfile:
    fieldnames = [
        'datetime'
        'latitude',
        'lat_direction',
        'longitude',
        'long_direction',
        'altitude',
        'speed',
        'course']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writerow({
        'datetime': '',
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


def send_at(command, back, timeout):
    rec_buff = ''
    ser.write((command + '\r\n').encode())
    time.sleep(timeout)
    if ser.inWaiting():
        time.sleep(0.01)
        rec_buff = ser.read(ser.inWaiting())
    if rec_buff != '':
        if back not in rec_buff.decode():
            print(command + ' ERROR')
            print(command + ' back:\t' + rec_buff.decode())
            return 0
        else:
            data_list = (rec_buff.decode())[25:-8].rsplit(",")
            if(len(data_list) == 9 and data_list[0] != ''):
                data_dict = {
                    "datetime": data_list[4] + " " + data_list[5],
                    "latitude": data_list[0],
                    "lat_direction": data_list[1],
                    "longitude": data_list[2],
                    "long_direction": data_list[3],
                    "altitude": data_list[6],
                    "speed": data_list[7],
                    "course": data_list[8],
                }
                write_to_csv(data_dict)
                client.publish("accounts/midnight_sun/GPS",
                               payload=json.dumps(data_dict),qos=2)
                dynamo_db_table.put_item(Item=data_dict)
            return 1
    else:
        print('GPS is not ready')
        return 0


def write_to_csv(data_dict):
    with open('gps_data.csv', 'a', newline='') as csvfile:
        fieldnames = [
            'datetime'
            'latitude',
            'lat_direction',
            'longitude',
            'long_direction',
            'altitude',
            'speed',
            'course']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writerow(data_dict)


def get_gps_position():
    rec_null = True
    answer = 0
    print('Start GPS session...')
    rec_buff = ''
    send_at('AT+CGPS=1,1', 'OK', 1)
    time.sleep(2)
    while rec_null:
        answer = send_at('AT+CGPSINFO', '+CGPSINFO: ', 1)
        if 1 == answer:
            answer = 0
            if ',,,,,,' in rec_buff:
                print('GPS is not ready')
                rec_null = False
                time.sleep(1)
        else:
            print('error %d' % answer)
            rec_buff = ''
            send_at('AT+CGPS=0', 'OK', 1)
            return False
        time.sleep(1.5)


def power_on(power_key):
    print('SIM7600X is starting:')
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)
    GPIO.setup(power_key, GPIO.OUT)
    time.sleep(0.1)
    GPIO.output(power_key, GPIO.HIGH)
    time.sleep(2)
    GPIO.output(power_key, GPIO.LOW)
    time.sleep(20)
    ser.flushInput()
    print('SIM7600X is ready')


def power_down(power_key):
    print('SIM7600X is logging off:')
    GPIO.output(power_key, GPIO.HIGH)
    time.sleep(3)
    GPIO.output(power_key, GPIO.LOW)
    time.sleep(18)
    print('Good bye')


def main():
    connect()
    try:
        power_on(power_key)
        get_gps_position()
        power_down(power_key)
    except BaseException:
        if ser is not None:
            ser.close()
            power_down(power_key)
            GPIO.cleanup()
        if ser is not None:
            ser.close()
            GPIO.cleanup()


if __name__ == "__main__":
    main()
