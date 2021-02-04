# Refer to https://www.elinux.org/Serial_port_programming to understand how these test scripts work
# This link is also helpful https://pimylifeup.com/raspberry-pi-serial/
import serial
import time

def readlineCR(port):
    rv = ""
    while True:
        ch = port.read()
        rv += ch
        if ch=='\r' or ch=='':
            return rv

port = serial.Serial("/dev/ttyAMA0", baudrate=115200, timeout=3.0)

while True:
    port.write("\r\nSay something:")
    rcv = readlineCR(port)
    port.write("\r\nYou sent:" + repr(rcv))