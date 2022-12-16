#include "Configuration.h"

#ifdef USE_EDGE_ENGINE
void edgeInit(edgine* Edge, connection* Connection ){
 
 Connection = connection::getInstance();
 Connection->setupConnection(SSID_WIFI, PASS_WIFI);      // connect the device to the WIFI
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
}

  void postMeasurement(edgine* Edge, vector<sample*> samples){
    Edge->evaluate(samples);
  }
#endif // USE_EDGE_ENGINE
