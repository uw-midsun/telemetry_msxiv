# Script for testing websockets and driver display
import asyncio
import websockets


async def hello(websocket, path):
    while True:
        # Test faults
        # await websocket.send("BPS_HEARTBEAT-BMS_CARRIER-{'status': 1}")
        # await asyncio.sleep(2)
        # await websocket.send("CHARGER_FAULT-CHARGER-{'fault': 1}")
        # await asyncio.sleep(2)
        # await websocket.send("CHARGER_FAULT-CHARGER-{'fault': 3}")
        # await asyncio.sleep(2)
        # await websocket.send("SOLAR_FAULT-CHARGER-{'fault': 5}")
        # await asyncio.sleep(2)

        # Test speed
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 20,'vehicle_velocity_right': 20}")
        await asyncio.sleep(1)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 40,'vehicle_velocity_right': 40}")
        await asyncio.sleep(1)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 60,'vehicle_velocity_right': 60}")
        await asyncio.sleep(1)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 80,'vehicle_velocity_right': 80}")
        await asyncio.sleep(1)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 100,'vehicle_velocity_right': 100}")
        await asyncio.sleep(1)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 120,'vehicle_velocity_right': 120}")
        await asyncio.sleep(1)
        await websocket.send("MOTOR_VELOCITY-MOTOR_CONTROLLER-\
        {'vehicle_velocity_left': 140,'vehicle_velocity_right': 140}")
        await asyncio.sleep(1)

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
