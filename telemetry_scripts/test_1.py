#!/usr/bin/env python

# WS server example

import asyncio
import websockets
import time

async def hello(websocket, path):
    while True:
        greeting = "Hello!"
        await websocket.send(greeting)
        await websocket.send("yuh")
        await websocket.send("boy")
        print(f"> {greeting}")

start_server = websockets.serve(hello, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()