float Size=5;
float Height=5;

show(string texture)
{
   

        llParticleSystem([
            PSYS_PART_FLAGS, 0,
            PSYS_SRC_PATTERN, 4,
            PSYS_PART_START_ALPHA, 0.50,
            PSYS_PART_END_ALPHA, 0.50,
            PSYS_PART_START_COLOR, <1.0,1.0,1.0>,
            PSYS_PART_END_COLOR, <1.0,1.0,1.0>,
            PSYS_PART_START_SCALE, <Size * 1.6 ,Size,0.00>,
            PSYS_PART_END_SCALE, <Size * 1.6,Size,0.00>,
            PSYS_PART_MAX_AGE, 1.20,
            PSYS_SRC_MAX_AGE, 0.00,
            PSYS_SRC_ACCEL, <0.0,0.0,0.0>,
            PSYS_SRC_ANGLE_BEGIN, 0.00,
            PSYS_SRC_ANGLE_END, 0.00,
            PSYS_SRC_BURST_PART_COUNT, 8,
            PSYS_SRC_BURST_RADIUS, Height,
            PSYS_SRC_BURST_RATE, 0.10,
            PSYS_SRC_BURST_SPEED_MIN, 0.00,
            PSYS_SRC_BURST_SPEED_MAX, 0.00,
            PSYS_SRC_OMEGA, <0.00,0.00,0.00>,
            PSYS_SRC_TEXTURE, texture]);
    
 
    
}
default
{
    state_entry()
    {
        show(llGetInventoryName(INVENTORY_TEXTURE,0));
    }
    changed(integer change)
    {
           show(llGetInventoryName(INVENTORY_TEXTURE,0));
    }
}