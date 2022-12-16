#include "Configuration.h"


#ifdef USE_GPS_NEO
    int Calculate_speed()
    {
        if (gps.speed.isValid())
            return int(gps.speed.kmph());
        else
            return -1;
        //delay(100);
    }
#endif
