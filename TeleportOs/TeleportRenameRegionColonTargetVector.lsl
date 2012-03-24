// === SET DESTINATION INFO HERE ===
string Destination = "Pyramidosita";   // your target destination here (SEE NEXT LINES) Can Be
vector LandingPoint = <128,128,21>;     // the landing point for avatar to arrive at
vector LookAt = <1,1,1>;                // which way they look at when arriving

// === SET USAGE MODES HERE ===
integer TouchTelePort = TRUE;          // set to TRUE if you want TP on Touch
integer CollideTeleport = TRUE;         // set to TRUE if you want to TP on Collision
//                                      // NOTE:  Collisions CAN be tricky in OpenSim 
// ========================================================================================


//XEngine;lsl
// ----------------------------------------------------------------
// Script Title:    OS_Teleport(Touch & Collision)
// Created by:      WhiteStar Magic
// Creation Date:   25/11/2009
// Platforms:
//    OpenSim:       Y, Tested and Operational on OpenSim git# f605d59 - r11575
//
// Revision:        0.3
//
// Conditions:
// Please maintain this header. If you modify the script indicate your
// revision details / enhancements
//
// Support:         NONE
//
// Licensing:       OpenSource.  Do as you will with it!
//
// ================================================================
// NOTES:
// Single Target Destination ONLY
// Alternatives are available for Multi-Desination in the OSG Forums (Scripting forum)
//
// Set Destination as described below, There are a Few Options depending on Application:  
//      Destination = "1000,1000";                 = In-Grid Map XXXX,YYYY coordinates
//      Destination = "RegionName";                = In-Grid-TP to RegionName
//      Destination = "TcpIpAddr:Port:RegionName"; = HyperGrid-TP method
//      Destination = "DNSname:Port:RegionName";   = HyperGrid-TP method
// 
// Set your Desired Mode for Touch AND/OR Collision
// DEFAULT = Touch OFF, Collision ON
// ========================================================================================
// 
//                  DO NOT MODIFY BELOW UNLESS YOU ARE CERTAIN
// ========================================================================================
list LastAgents = [];                   // retention list for de-bouncer used for Collisions
                                        // preventing Multiple Triggers from occuring
key agent;
//
PerformTeleport( key AgentToTP )
{
    llWhisper(0, "Teleporting you to : "+llGetScriptName());
    
    integer TimeNow = llGetUnixTime();
    integer a_idx = llListFindList( LastAgents, [ AgentToTP ] );
    if (a_idx != -1)
    {
        integer TimeLast = llList2Integer( LastAgents, a_idx + 1 );
        if (TimeLast >= (TimeNow - 6)) return;
        LastAgents = llDeleteSubList( LastAgents, a_idx, a_idx+1);
    }
    LastAgents += [ AgentToTP, TimeNow ];  // agent just TP'd so add to list with NOWTIME
  llRegionSay(9999,AgentToTP+":"+llGetScriptName());
    //osTeleportAgent(AgentToTP, Destination, LandingPoint, LookAt);    
} 

rbDiapo(string texture,float scalex, float scaley)
{
    //llSay(0,"hello "+texture);
        
    
        llParticleSystem([
            PSYS_PART_FLAGS, 1,
            PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_DROP,
            PSYS_PART_START_ALPHA, .8,
            PSYS_PART_END_ALPHA, 1,
            PSYS_PART_START_COLOR, <1.0,1.0,1.0>,
            PSYS_PART_END_COLOR, <1.0,1.0,1.0>,
            PSYS_PART_START_SCALE, <scalex ,scaley,0.00>,
            PSYS_PART_END_SCALE, <scalex*2,scaley*2,0.00>,
            PSYS_PART_MAX_AGE, 3,
            PSYS_SRC_MAX_AGE, 0.00,
            PSYS_SRC_ACCEL, <0.0,0.0,0.0>,
            PSYS_SRC_ANGLE_BEGIN, 0.00,
            PSYS_SRC_ANGLE_END, 0.00,
            PSYS_SRC_BURST_PART_COUNT, 4,
            PSYS_SRC_BURST_RADIUS, 2.50,
            PSYS_SRC_BURST_RATE, 0.1,
            PSYS_SRC_BURST_SPEED_MIN, 0.00,
            PSYS_SRC_BURST_SPEED_MAX, 0.00,
            PSYS_SRC_OMEGA, <0.00,0.00,0.00>,
            PSYS_SRC_TEXTURE, texture]);
            
  //          rbSetText();
    }
    
//============
// MAIN APP 
//============  
default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
    changed(integer change)     // something changed, take action
    {
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
        else if (change & 256)  // that bit is set during a region restart
        {                       
            llResetScript();
        }
    }
    
    state_entry()
    {
        //llSetTexture(llGetObjectDesc(),ALL_SIDES);
        rbDiapo(llGetObjectDesc(),0.5,0.5);
        string TOUCH = "OFF";
        string COLLIDE = "OFF";
        if(TouchTelePort) TOUCH = "ON";
        if(CollideTeleport) COLLIDE = "ON";
        llOwnerSay("Teleportal Active: Collision = "+COLLIDE+" / Touch = "+TOUCH);
    }
   
    touch_start(integer num_detected) 
    {
        key agent = llDetectedKey(0);
        if(TouchTelePort) PerformTeleport( agent );
    }
    
    // This is TRICKY / FLAKY  Alternates are COMMENTED here. REMOVE the first // and comment out the collision*() you wish to try
    //collision(integer num_detected)         // Triggers IMMEDIATE Response on Contact / Collision. OFTEN Causes Duplicate trigger
    //collision_end(integer num_detected)     // Will WAIT till collisions are COMPLETED, 
                                              // means a DELAY till collisions stop so you have to BACK OFF the prim & collisions Stop
                                              //
    collision_start(integer num_detected)   // Immediate Response, CAN cause multiple HITS, INFREQUENTLY (WORKS BEST)
    {
        key agent = llDetectedKey(0);
        if(CollideTeleport) PerformTeleport( agent );
    }
} 