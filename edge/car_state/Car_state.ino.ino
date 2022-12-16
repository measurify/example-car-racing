#include "Configuration.h"

#ifdef USE_GPS_NEO
    #include <TinyGPSPlus.h>
#endif

#ifdef USE_EDGE_ENGINE
  #include <EdgeEngine_library.h>
#endif

#ifdef USE_LSM
  #include <Wire.h>
  #include <Adafruit_LSM9DS1.h>
  #include <Adafruit_Sensor.h>
#endif

#ifdef USE_GPS_NEO
  TinyGPSPlus gps;
  int _speed = -1;
#endif


#ifdef USE_LSM
  Adafruit_LSM9DS1 lsm = Adafruit_LSM9DS1();
  float accX; float accY; float accZ; 
#endif

#ifdef USE_EDGE_ENGINE
 sample* stateSample = NULL;
 vector<sample*> samplesVect_state;
#endif //USE_EDGE_ENGINE

#ifdef USE_EDGE_ENGINE
  edgine* Edge;
  connection* Connection;
#endif USE_EDGE_ENGINE

double stime = 0;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(BAUD_RATE);
  
  #ifdef USE_GPS_NEO
    Serial2.begin(BAUD_RATE);
  #endif

  #ifdef USE_LSM
    if (!lsm.begin()) {
    Serial.println(F("Oops… Unable to initialize the LSM9DS1. Check your wiring!"));
    while (1);
  }
  Serial.println(F("Found LSM9DS1 9DOF"));
  lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_2G);
  #endif
  
  #ifdef USE_EDGE_ENGINE
   Connection = connection::getInstance();
   Connection->setupConnection(SSID_WIFI, PASS_WIFI); 
   options opts;

   opts.username      =   USERNAME;
   opts.password      =   PASSWORD;
   opts.tenant        =   TENANT;
    //route
   opts.url           =   URL;
   opts.ver           =   VERSION;
   opts.login         =   LOGIN;
   opts.devs          =   DEVICES;
   opts.scps          =   SCRIPTS;
   opts.measurements  =   MEASUREMENTS;
   opts.info          =   INFO;
   opts.issues        =   ISSUES;
    //Edgine identifiers
   opts.thing         =   THING;
   opts.device        =   DEVICE;
   opts.id            =   ID;
  
    //initialize Edge engine
   Edge=edgine::getInstance();
   Edge->init(opts);             // initialize Edge Engine with the passed options
  #endif // USE_EDGE_ENGINE

}

void loop() {
  // put your main code here, to run repeatedly:
  
  #ifdef USE_GPS_NEO
    while (Serial2.available() > 0){
      //Serial.print(F("Encoding..."));
      if (gps.encode(Serial2.read())){
        Serial.print(F("Encoding..."));
        _speed = Calculate_speed();
      }
        
    }

     /*DEBUG
    Serial.print(F("Speed: ")); Serial.print(_speed); Serial.print(F("m/s"));
    Serial.print("\n");
    */
        
  #endif

  

  #ifdef USE_LSM
    lsm.read();  /* ask it to read in the data */ 

    /* Get a new sensor event */ 
    sensors_event_t a, m, g, temp;
    lsm.getEvent(&a, &m, &g, &temp);

    accX = a.acceleration.x;
    //accY = a.acceleration.y;
    //accZ = a.acceleration.z;

    /*DEBUG
    Serial.print(F("Accel X: ")); Serial.print(accX); Serial.print(F(" m/s^2"));
    Serial.print(F("\tY: ")); Serial.print(accY); Serial.print(F(" m/s^2"));
    Serial.print(F("\tZ: ")); Serial.print(accZ); Serial.print(F(" m/s^2"));
    Serial.print("\n");
    */
  #endif

  #ifdef USE_EDGE_ENGINE
    stateSample = new sample("state");
    stateSample->startDate = Edge->Api->getActualDate();        
    stateSample->endDate = stateSample->startDate;
    stateSample->sizeOfSamples = Edge->getItems();
    stateSample->myArray.assign(stateSample->sizeOfSamples, 0);
    stateSample->myArray[0] = _speed;
    stateSample->myArray[1] = a.acceleration.x;
    samplesVect_state.push_back(stateSample);
  #endif //USE_EDGE_ENGINE

  #ifdef USE_EDGE_ENGINE
    Edge->evaluate(samplesVect_state);
    samplesVect_state.clear();
    delete stateSample;
    
  #endif //USE_EDGE_ENGINE

  Serial.print((millis()-stime));
  stime = millis();
  //delay(20);

}
