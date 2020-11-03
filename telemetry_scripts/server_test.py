#!/usr/bin/env python

# WS server example

import asyncio
import websockets
import time


async def hello(websocket, path):
    while True:
        # Test speed
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-{'vehicle_velocity_left': 127, 'vehicle_velocity_right': 127}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-{'vehicle_velocity_left': 128, 'vehicle_velocity_right': 128}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-{'vehicle_velocity_left': 129, 'vehicle_velocity_right': 129}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-{'vehicle_velocity_left': 130, 'vehicle_velocity_right': 130}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-{'vehicle_velocity_left': 131, 'vehicle_velocity_right': 131}")
        await asyncio.sleep(0.5)

start_server = websockets.serve(hello, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
