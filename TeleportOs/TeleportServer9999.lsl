default
{
    state_entry()
    {
        llSetText("Teleport server",<1,1,1>,1);
        llListen(9999,"",NULL_KEY,"");
    }
    listen(integer channel,string name,key id,string str)
    {
        list pieces=llParseStringKeepNulls(str,[":"],[]);
        key idav=(key)llList2String(pieces,0);
        string region=llList2String(pieces,1);
        vector landing=(vector)llList2String(pieces,2);
        vector lookat=(vector)llList2String(pieces,3);
        osTeleportAgent(idav,region,landing,lookat);
    }
}