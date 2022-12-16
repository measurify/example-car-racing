#ifndef CONFIG_DEFINED__
#define CONFIG_DEFINED__

#undef USE_GPS_NEO
#define USE_GPS_NEO


#undef USE_LSM
#define USE_LSM

#undef USE_EDGE_ENGINE
#define USE_EDGE_ENGINE

////////////////////////////////////////////////////////

#ifdef USE_GPS_NEO
  int Calculate_speed();
#endif

#ifdef USE_LSM
  void setupSensor();
#endif

const int BAUD_RATE         = 9600;



#ifdef USE_EDGE_ENGINE
  #include <EdgeEngine_library.h>
  const char* SSID_WIFI =   "Redmi1";
  const char* PASS_WIFI =   "ciao1234";
  #define     USERNAME      "car-manager-user-username"
  #define     PASSWORD      "car-manager-user-password"
  #define     TENANT        "car-manager-tenant"
  #define     URL           "https://students.measurify.org"
  #define     VERSION       "v1"
  #define     LOGIN         "login"
  #define     DEVICES       "devices"
  #define     SCRIPTS       "scripts"
  #define     MEASUREMENTS  "measurements"
  #define     INFO          "info"
  #define     ISSUES        "issues"
  #define     THING         "Car 01"
  #define     DEVICE        "car-device"
  #define     ID            "car-device"
 
  void EdgeInit(edgine* Edge, connection* Connection ); // initialize Edge Engine
  void postMeasurement(edgine* Edge, vector<sample*> samples);
#endif //USE_EDGE_ENGINE


#endif // CONFIG_DEFINED__
