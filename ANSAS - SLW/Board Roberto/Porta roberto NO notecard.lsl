list lines=[
"Qual è il presidente degli stati uniti?",
"*Obama",
"Nixon",
"Pertini"
];
list avatars=[];
list flags=[]; // per ogni avatar segno 1 se ha risposto esatto oppure -1 -2 se ha sbagliato n volte
integer MAXERRORS=-2; // massimo numero di volte

integer i=0;

string question;
list answers;
integer correct;

integer CHANNEL=9999;

opendoor()
{
    llSay(0,"La porta si apre...");
    llSetPrimitiveParams([ PRIM_TYPE, PRIM_TYPE_CYLINDER, 0, <0.250000, 0.750000, 0.0>, 0.700000, ZERO_VECTOR, <1.0, 1.0, 0.0>, ZERO_VECTOR ]);
    llSetTimerEvent(10);
}
closedoor()

{
    llSay(0,"La porta si chiude...");
    llSetPrimitiveParams([PRIM_TYPE, PRIM_TYPE_CYLINDER, 0, <0.250000, 0.750000, 0.0>, 0.0, ZERO_VECTOR, <1.0, 1.0, 0.0>, ZERO_VECTOR, PRIM_SIZE, <9.5, 9.5, 0.10000>]);
}

default
{
    state_entry()
    {
        //llSay(0,llList2CSV(llGetPrimitiveParams([PRIM_TYPE])));
        llSetStatus(STATUS_PHANTOM,FALSE);
        closedoor();
       
        llSetText(".",<1,1,1>,1);
        question=llList2String(lines,0);
        integer c=1; 
        for(c=1;c<llGetListLength(lines);c++)
        {
            string l=llList2String(lines,c);
            if(llGetSubString(l,0,0)=="*")
            {
                l=llGetSubString(l,1,-1);
                correct=c;
                //llSay(0,"corretta: "+(string)correct);
                
            }
            //llSay(0,"adding "+l+" to array ");
            answers+= [l];
        }

        llSetText(" " /* "Ready ("+(string)llGetListLength(answers)+")"*/ ,<1,1,1>,1);
        //llVolumeDetect(TRUE);
        llListen(-1,"",NULL_KEY,"");
        llListen(100,"",NULL_KEY,"");
        llSetStatus(STATUS_PHANTOM,FALSE);
        
    }
    listen(integer channel, string name, key id, string str)
    {
        if(channel==100)
        {
            llSay(100,"reset");
            llResetScript();
            return;
        }
        integer av=llListFindList(avatars,[id]);
        if(av<0) return;
        
        integer position=llListFindList(answers,[str])+1;
        llSay(0,"position: "+(string)position+" correct: "+(string)correct);
        if(position==correct)
        {
            flags=llListReplaceList(flags,[1],av,av);
            llSay(0,name+" hai risposto correttamente");
            llRegionSay(CHANNEL,name+",1,1");
            opendoor();
            return;
        }

        llRegionSay(CHANNEL,name+",0,1");
        
        llSay((integer)("0x"+(string)id),(string)id+" -10");
        integer flag=(integer)llList2String(flags,av)-1;
        flags=llListReplaceList(flags,[  flag ],av,av);
        
        //llSay(0,name+" penalità di 10 punti flag: "+(string)flag);
        
        
    }
    touch_start(integer count)
    {
        integer c;
        for(c=0;c<count;c++)
        {
            string name=llDetectedName(c);
            key av=llDetectedKey(c);
            
            integer found=0;
            if((found=llListFindList(avatars,[ av ]))<0) 
            {
                // non c'era prima aggiungi 
                avatars+= [ av ];
                flags+= [ 0 ];
                found=llGetListLength(avatars)-1;
            }
            integer flag=(integer)llList2String(flags,found);
            //llSay(0,(string)flag);
           /* if(flag<=MAXERRORS)
            {
                llSay(0,name+" non puoi più hai già fatto troppi tentativi");
                return;
            }*/
            if(flag>0)
            {
               
                opendoor();
                return;
            }
            llSay(0,"Domanda per "+name);
            llDialog(av,question,answers,-1);
        }
        
    }
    timer()
    {
        llSetTimerEvent(0);
        closedoor();
    }
}
