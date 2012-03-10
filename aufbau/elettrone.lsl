vector diffpos;
rotation rot;
vector pivot;
string NAME="Pivot Piramide";

integer CHANNEL;

doCrash()
{
        // crash means go no bright
        llSetPrimitiveParams([PRIM_FULLBRIGHT, ALL_SIDES, FALSE]);

}

turnOn()
{
    llSetPrimitiveParams([PRIM_FULLBRIGHT, ALL_SIDES, TRUE]);
}
moveBack()
{
  doCrash();
}

// default state
default
{
   
    state_entry()
    {
      CHANNEL=(integer)("0x"+llGetOwner()); 
      llListen(CHANNEL,"",NULL_KEY,"");
      llOwnerSay("Listening to channel "+CHANNEL);
    }
    changed(integer change)
    {
        if(change & CHANGED_OWNER) llResetScript();
    }

   

    listen(integer channel,string name,key id,string str)
    {
        if(str=="CRASH")
        {

            doCrash();
            llSetTimerEvent(60*5); // after 5 minutes goes back to position
            return;
        }
        if(str=="PUTBACK")
        {
            moveBack();
            return;
        }
        if(str=="RECORD")
        {
            
            llSetObjectDesc(llList2CSV([ llGetPos(), llGetRot() ]));
            llOwnerSay("Recording position: "+llGetObjectDesc());
            return;
        }
        //llOwnerSay("Ricevuto "+str+" my key: "+(string)llGetKey());
        list lcmd=llCSV2List(str);
        string cmd=llList2String(lcmd,0);
        string to=llList2String(lcmd,1);
        if(cmd=="OK" && to==(string)llGetKey())
        {
           // llSay(0,"authorized");
            turnOn();
            return;
        }
    }
    timer()
    {
        llSetTimerEvent(0);
        moveBack();
    }
    touch_start(integer count)
    {
        // deve chiedere autorizzazione al pivot
        //llOwnerSay("AUTH,"+(string)llGetKey());
        llSay(CHANNEL,"AUTH,"+(string)llGetKey());
       // sense();
    }
  
}
