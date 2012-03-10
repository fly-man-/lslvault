float sizex=6;
float sizey=6;

 
  
   
show()
 {
 string texture=llGetInventoryName(INVENTORY_TEXTURE,0);
        // mask flags - set to TRUE (or 1) to enable
        integer bounce = 0;    // Make particles bounce on Z plane of object
        integer glow = 1;        // Make the particles glow
        integer interpColor =0;    // Go from start to end color
        integer interpSize = 0;    // Go from start to end size
        integer followSource = 0;    // Particles follow the source
        integer followVel = 0;    // Particles turn to velocity direction
        integer wind = 0;        // Particles affected by wind
        //pattern:
        //integer pattern = PSYS_SRC_PATTERN_ANGLE;
        //integer pattern = PSYS_SRC_PATTERN_ANGLE_CONE_EMPTY;
        //integer pattern = PSYS_SRC_PATTERN_ANGLE_CONE;
        integer pattern = PSYS_SRC_PATTERN_DROP;
        //integer pattern = PSYS_SRC_PATTERN_EXPLODE;
        // Select a target for particles to go towards
        // "" for no target, "owner" will follow object owner
        //    and "self" will target this object
        //    or put the key of an object for particles to go to
        key target = ""; 
        //key target = "self";
        //key target = "owner";
        // particle parameters
        float age = 30;                  // Life of each particle
        float maxSpeed = 0;            // Max speed each particle is spit out at
        float minSpeed = 0;            // Min speed each particle is spit out at
        //string texture = "44956ff0-45cd-4952-a393-063172903839";           // Texture used for particles, default used if blank
        float startAlpha = 1;           // Start alpha (transparency) value
        float endAlpha = 1;           // End alpha (transparency) value (if interpColor = TRUE)
        vector startColor = <1,1,1>;    // Start color of particles <R,G,B>
        vector endColor = <1,1,1>;      // End color of particles <R,G,B> (if interpColor = TRUE)
        vector startSize = <sizex,sizey,0>;     // Start size of particles <x,y>
        vector endSize = <sizex,sizey,0>;       // End size of particles (if interpSize == TRUE)
        vector push = <0,0,0>;          // Force pushed on particles
        // system parameters
        float life = 0;             // Life in seconds for the system to make particles
        integer count = 1;        // How many particles to emit per BURST
        float rate = 0.03f;            // How fast (rate) to emit particles
        float radius = 2;          // Radius to emit particles for BURST pattern
        float outerAngle = 1.54;    // Outer angle for all ANGLE patterns
        float innerAngle = 1.55;    // Inner angle for all ANGLE patterns
        vector omega = <0,0,0>;    // Rotation of ANGLE patterns around the source
        integer flags = 0;
            if (target == "owner") target = llGetOwner();
            if (target == "self") target = llGetKey();
            if (glow == 1) flags = flags | PSYS_PART_EMISSIVE_MASK;
            if (bounce == 1) flags = flags | PSYS_PART_BOUNCE_MASK;
            if (interpColor == 1) flags = flags | PSYS_PART_INTERP_COLOR_MASK;
            if (interpSize == 1) flags = flags | PSYS_PART_INTERP_SCALE_MASK;
            if (wind == 1) flags = flags | PSYS_PART_WIND_MASK;
            if (followSource == 1) flags = flags | PSYS_PART_FOLLOW_SRC_MASK;
            if (followVel == 1) flags = flags | PSYS_PART_FOLLOW_VELOCITY_MASK;
            if (target != "") flags = flags | PSYS_PART_TARGET_POS_MASK;
            llParticleSystem([  PSYS_PART_MAX_AGE,age,
                                PSYS_PART_FLAGS,flags,
                                PSYS_PART_START_COLOR, startColor,
                                PSYS_PART_END_COLOR, endColor,
                                PSYS_PART_START_SCALE,startSize,
                                PSYS_PART_END_SCALE,endSize,
                                PSYS_SRC_PATTERN, pattern,
                                PSYS_SRC_BURST_RATE,(float)rate,
                                PSYS_SRC_ACCEL, push,
                                PSYS_SRC_BURST_PART_COUNT,count,
                                PSYS_SRC_BURST_RADIUS,(float)radius,
                                PSYS_SRC_BURST_SPEED_MIN,(float)minSpeed,
                                PSYS_SRC_BURST_SPEED_MAX,(float)maxSpeed,
                                PSYS_SRC_TARGET_KEY,target,
                                PSYS_SRC_INNERANGLE,(float)innerAngle,
                                PSYS_SRC_OUTERANGLE,(float)outerAngle,
                                PSYS_SRC_OMEGA, omega,
                                PSYS_SRC_MAX_AGE, (float)life,
                                PSYS_SRC_TEXTURE, texture,
                                PSYS_PART_START_ALPHA, (float)startAlpha,
                                PSYS_PART_END_ALPHA, (float)endAlpha
                                    ]);
}
//Originally by Ama Omega
default
{
    state_entry()
    {
       show();
    }
    changed(integer change)
    {
        show();
    } 
}