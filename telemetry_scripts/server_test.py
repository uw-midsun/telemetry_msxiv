import asyncio
import websockets


async def hello(websocket, path):
    while True:
        # Test speed
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 127,'vehicle_velocity_right': 127}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 128,'vehicle_velocity_right': 128}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 129,'vehicle_velocity_right': 129}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 130,'vehicle_velocity_right': 130}")
        await asyncio.sleep(0.5)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 131,'vehicle_velocity_right': 131}")
        await asyncio.sleep(0.5)

        # Test changing states (off,drive,reverse)
        await websocket.send("DRIVE_STATE-MOTOR_CONTROLLER-{'drive_state': 0}")
        await asyncio.sleep(2)
        await websocket.send("DRIVE_STATE-MOTOR_CONTROLLER-{'drive_state': 1}")
        await asyncio.sleep(2)
        await websocket.send("DRIVE_STATE-MOTOR_CONTROLLER-{'drive_state': 2}")

        # Test left/right signal (left then right)
        await websocket.send("LIGHTS-STEERING-{'lights_id': 0, 'state': 1}")
        await asyncio.sleep(2)
        await websocket.send("LIGHTS-STEERING-{'lights_id': 5, 'state': 1}")
        await asyncio.sleep(2)
        await websocket.send("LIGHTS-STEERING-{'lights_id': 0, 'state': 0}")
        await asyncio.sleep(2)
        await websocket.send("LIGHTS-STEERING-{'lights_id': 5, 'state': 0}")
        await asyncio.sleep(2)

start_server = websockets.serve(hello, "localhost", 8765)


asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
