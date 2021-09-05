# Script for testing websockets and driver display
import asyncio
import websockets


async def hello(websocket, path):
    async def testSpeed(speed: float):
        await websocket.send(f"MOTOR_VELOCITY-MOTOR_CONTROLLER-{{'vehicle_velocity_left': {speed},'vehicle_velocity_right': {speed}}}")
        await asyncio.sleep(1)

    async def testDriveState(drive_state: int):
        await websocket.send(f"DRIVE_STATE-MOTOR_CONTROLLER-{{'drive_state': {drive_state}}}")
        await asyncio.sleep(1)

    async def testLights(lights_id: int, isOn: bool):
        state = 1 if isOn else 0
        await websocket.send(f"LIGHTS-STEERING-{{'lights_id': {lights_id}, 'state': {state}}}")
        await asyncio.sleep(1)

    while True:
        # Test faults
        await websocket.send("BPS_HEARTBEAT-BMS_CARRIER-{'status': 1}")
        await asyncio.sleep(2)
        await websocket.send("CHARGER_FAULT-CHARGER-{'fault': 1}")
        await asyncio.sleep(2)
        await websocket.send("CHARGER_FAULT-CHARGER-{'fault': 3}")
        await asyncio.sleep(2)
        await websocket.send("SOLAR_FAULT-CHARGER-{'fault': 5}")
        await asyncio.sleep(2)
        await websocket.send("SOLAR_FAULT-CHARGER-{'fault': 3}")
        await asyncio.sleep(2)

        # Test speed
        for i in range(0, 140, 20):
            await testSpeed(i)

        # Test changing states (off,drive,reverse)
        for i in range(3):
            await testDriveState(i)

        # Test lights (turn signals and DRL)
        for i in [0, 3, 4, 5]:
            await testLights(i, True)
            await testLights(i, False)

        # Test cruise
        await websocket.send("CRUISE_CONTROL_COMMAND-STEERING-{'command': 147}")
        await asyncio.sleep(2)
        await websocket.send("CRUISE_CONTROL_COMMAND-STEERING-{'command': 147}")
        await asyncio.sleep(2)

        # Test Lights
        await websocket.send("REGEN_BRAKING-STEERING-{'test': 1}")
        await asyncio.sleep(2)
        await websocket.send("REGEN_BRAKING-STEERING-{'test': 1}")
        await asyncio.sleep(2)


start_server = websockets.serve(hello, "localhost", 8765)


asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
