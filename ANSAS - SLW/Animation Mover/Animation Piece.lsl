integer CHANNEL;
integer HANDLE=0;


init()
{
        CHANNEL=(integer)("0x"+llGetKey());
        llSay(0,"CHANNEL:"+(string)CHANNEL);
        if(HANDLE!=0)llListenRemove(HANDLE);
        HANDLE=llListen(CHANNEL,"",NULL_KEY,"");
}    

default
{
    on_rez(integer int)
    {
        init();
    }
    state_entry()
    {
        init();
    }
    listen(integer channel,string name,key id,string str)
    {
        list decode=llCSV2List(str);
        integer chan=llList2Integer(decode,0);
        vector pos=llList2Vector(decode,1);
        rotation rot=llList2Rot(decode,2);
        key toid=llList2Key(decode,3);
        if(toid!=llGetKey()) return;
        llSetPrimitiveParams([ PRIM_POSITION, pos, PRIM_ROTATION, rot ]);
    }
    touch_start(integer cnt)
    {
        llRegionSay(1000,llList2CSV([ "SET", llGetPos(), llGetRot()]));
    }
}