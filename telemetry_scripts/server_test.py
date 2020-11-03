#!/usr/bin/env python

# WS server example

import asyncio
import websockets


async def hello(websocket, path):
    while True:
        await websocket.send("CRUISE_TARGET,STEERING,{'target_speed': 130}")
        await websocket.send("CRUISE_TARGET,STEERING,{'target_speed': 0}")
        await websocket.send("LIGHTS,STEERING,{'lights_id': 3, 'state': 1}")
        await websocket.send("LIGHTS,STEERING,{'lights_id': 3, 'state': 1}")

start_server = websockets.serve(hello, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
