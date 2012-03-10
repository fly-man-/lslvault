list AUTH=
[ "Comincia a disporre gli elettroni per H idrogeno","1s-d", "aiutino" ,
  "Aggiungi elettrone per He Elio","1s-u"," ",
  "Aggiungi elettrone per Li Litio","2s-d"," ",
  "Aggiungi elettrone per Be Berillio","2s-u"," ",
  "Aggiungi elettrone per B  Boro","2p1-d", " ",
  "Aggiungi elettrone per C  Carbonio","2p2-d", " ",
  "Aggiungi elettrone per N  Azoto","2p3-d"," ",
  "Aggiungi elettrone per O  Ossigeno","2p1-u"," ",
  "Aggiungi elettrone per F  Fluoro","2p2-u"," ",
  "Aggiungi elettrone per Ne Neon","2p3-u"," "
   ];
  
integer BOARD;
integer INDEX=0; // incremented by 3
list EXPECTED; // list of objects allowed
string MESSAGE;

integer CHANNEL;
integer CDIALOG;

string pop()
{
    return llList2String(AUTH,INDEX++);
}
nextStage()
{
     if(INDEX>=llGetListLength(AUTH))
        {
            llSay(0,"Hai fatto tutto complimenti");
            llPlaySound("END",1);
            llSay(101,"Complimenti, hai finito l'esercizio");
            return;
            //llResetScript();
        }
    string msg=pop();
    llSay(0,msg); llWhisper(101,msg);
    EXPECTED=llCSV2List(pop()); // list of acceptable choices
    MESSAGE=pop(); // hint
}


default
{
    state_entry()
    {
        llSoundPreload("OK");
        llSoundPreload("KO");
        llSoundPreload("END");
        llSoundPreload("CRASH");
        llSetText("Click to play with the pyramid",<1,1,1>,1);
        CHANNEL=(integer)("0x"+llGetOwner());
        llListen(CHANNEL,"",NULL_KEY,"");
       CDIALOG=CHANNEL+1;
        llListen(CDIALOG,"",NULL_KEY,"");
        llOwnerSay("Listening on channel "+(string)CHANNEL);
        INDEX=0; nextStage(); BOARD=CHANNEL+2;
       // nextStage();
    }
    listen(integer channel, string name, key id, string str)
    {
        if(channel==CDIALOG)
        {
            if(str=="RIPARTI"){
                  llPlaySound("CRASH",1);
                  llSay(CHANNEL,"CRASH");
                  INDEX=0;
                  nextStage();                     
            }
            if(id!=llGetOwner()) return;
            
            if(str=="REGISTRA")
            {
                llSay(CHANNEL,"RECORD");
                
            }
            if(str=="RIMETTI")
            {
                llSay(CHANNEL,"PUTBACK");
            }
            return;
        }
      // llOwnerSay("ricevuto "+str+" da '"+name+"' expecting '"+llList2CSV(EXPECTED)+"'");
        integer i; integer found=-1;
        for(i=0;i<llGetListLength(EXPECTED);i++)
        {
            string test=llList2String(EXPECTED,i);
           // llOwnerSay("Checking '"+test+"' vs '"+name+"'");
            if(test==name) {  found=i; break;}
        }
       //  integer found=llListFindList(EXPECTED,[ llStringTrim(name,STRING_TRIM)]);
       // llOwnerSay("found: "+(string)found);
        if(found < 0 ){
            llSay(0,"*Sbagliato: "+MESSAGE);
            llPlaySound("KO",1);
            return;
        }
        //llSay(0,"OK");
        llSay(CHANNEL,"OK,"+(string)id);
        llPlaySound("OK",1);
        EXPECTED=llDeleteSubList(EXPECTED,found,found);
        if(llGetListLength(EXPECTED)==0)
        {
            nextStage(); 
            return;
        }
        
        
       
/*        list lcmd=llCSV2List(str);
        string cmd=llList2String(lcmd,0);
        string k=llList2String(lcmd,1);
        llSay(0,"received "+cmd+" and "+k);*/

    }
    changed(integer change)
    {
        // changed owner means we have
        if(change & CHANGED_OWNER)
        {
            // reset script to be sure we know the owner
            llResetScript();
        }
    }
    touch_start(integer count)
    {
        key id=llDetectedKey(0);
        //if(id==llGetOwner()) llDialog(llDetectedKey(0),"Scegli",["REGISTRA","DISFA","RIMETTI"],CDIALOG);
        //else 
        llDialog(llDetectedKey(0),"Scegli",["RIPARTI"],CDIALOG);
    }
      
}
