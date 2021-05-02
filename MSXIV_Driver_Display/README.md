# MSXIV_Driver_Display

This is the Driver Display for MSXIV.
Features such as the speedometer and battery life are displayed in this flutter app
for our solar car.
The data is pulled from our telemetry system using websockets.

## Getting Started

Install Flutter
- [Install flutter](https://flutter.dev/docs/get-started/install)

Refer to resources below to understand how to run the program:
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter see,
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Testing

+ Run the test server script (`../test_scripts/server_test.py`) - should be able to run it as a normal Python script using terminal/command prompt. Can stop using `ctrl + C`. It will send websockets events to be received by our client, the Flutter app. 
+ Then run the Flutter app as normal, and it should receive the above events and respond with visual changes to the interface.
