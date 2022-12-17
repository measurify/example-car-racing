# Design and development of an embedded system for motor racing management

This paper has been written with the objective of simulating the management of motor racing, particularly on-circuit qualifying sessions. 
The project is composed of two independent systems; the first deals with detecting the presence of a vehicle on the track and, consequently, detecting and processing data useful for car recognition and lap time of the car itself; the second deals with acquiring information necessary for telemetry management of the car. 
Then all the information acquired by the software is sent to an API (Application Protocol Interface) Cloud called Measurify. 
Finally, to enable a userfriendly representation of the data, a cross-platform application was created that allows the data collected to be visualized via graphs for the telemetry of the cars, and tables for the lap times of the cars. 

## Quick start
Since the project is divided into two independent systems, it is necessary to divide the steps for installation.

### Car tracking system and lap time acquisition

To setup this system, the following steps need to be followed:

  1. Install Visual Studio Code.
  
  2. Install the Python plugin.
  
  3. Open car_tracking folder (inside the edge folder in this repository).
  
  4. Now the sketch is ready to be compiled and executed.
  
### Speed and acceleration acquisition system

To setup this system, the following steps need to be followed:

  1. Install Arduino IDE.
  
  2. Inside the IDE settings, in: "File --> Settings --> Additional Boards Manager URLs" Specify the following libraries to make the IDE work with ESP32 boards:            https://dl.espressif.com/dl/package_esp32_index.json
  
  3. Install the following libraries:
    - TinyGPSPlus
    - Wire
    - Adafruit_LSM9DS1
    - Adafruit_Sensor

  4. Put the "EdgeEngine_library" inside the "libraries" folder. 
  
  5. Open car_state folder (inside the edge folder in this repository).
  
  6. Now the sketch is ready to be compiled and executed by the board.
 
 ### Car Manager
  
 To setup the mobile device, the following steps need to be followed:
 
  1. Install Visual Studio Code.
  
  2. Install the Flutter plugin.
  
  3. Open the car_manager folder (inside the folder client in this repository).
  
  4. Now the client application is ready to be debugged on a device.
  
 
  
