vector diffpos;
rotation rot;
vector pivot;
string NAME="Pivot Piramide";

integer CHANNEL;

doCrash()
{
        //    llSetStatus(STATUS_PHYSICS,TRUE);
        //    llApplyImpulse(<40+llFrand(10),40+llFrand(10),40+llFrand(10)>,FALSE);
        //    llSleep(3);
        //    llSetStatus(STATUS_PHYSICS,FALSE);
        vector p=llGetPos();
        vector r;
        p.x=p.x+llFrand(10)-5;
        p.y=p.y+llFrand(10)-5;
        p.z=llGround(llGetPos())+llFrand(10);
        
        r.x=llFrand(PI);
        r.y=llFrand(PI);
        r.z=llFrand(PI);
        
        
        llSetPos(p);
        llSetRot(llEuler2Rot(r)); 

}

moveBack()
{
  // llSay(0,"Moving to diff: "+(string)diffpos);
    //integer i=0;
    //while(i<3 && llVecDist(llGetPos(),p)>.1)
    //{
        list l=llCSV2List(llGetObjectDesc());
        llSetPos((vector)llList2String(l,0));
    //}
    llSetRot((rotation)llList2String(l,1));    
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
            moveBack();
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
        llOwnerSay("AUTH,"+(string)llGetKey());
        llSay(CHANNEL,"AUTH,"+(string)llGetKey());
       // sense();
    }
  
}
