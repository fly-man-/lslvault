

integer iSHOWN=0;
showhud(){
    debug("show hud");
    llSetPos(SHOWN);
    iSHOWN=1;
}
hidehud(){
    debug("hide hud");
    llSetPos(HIDDEN);
    iSHOWN=0;
}
togglehud()
{
    debug("toggle hud");
    iSHOWN=1-iSHOWN;
    if(iSHOWN==1) showhud(); else hidehud();
}

#define HUDLISTEN\
        if(cmd=="SHOW"){\
\
            showhud(); llSetTimerEvent(30);\
            return;\
        }\
         if(cmd=="HIDE"){\
\
            hidehud();\
            return;\
            \
        }\
        if(cmd=="TOGGLE"){\
            togglehud(); if(iSHOWN==1) llSetTimerEvent(30);\
        }



