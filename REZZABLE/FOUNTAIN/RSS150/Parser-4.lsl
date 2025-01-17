// use an object as a memory store
//
// due to problems in LSL handling of lists we have kind of leaks so if huge elements needed
// need to reset it often


string buffer;
list values=[];

integer DEBUG=0;

integer BANK=1; // which bank we are (it will taken from the name of the script xxxx-###)

integer ADD = 1; // add a buffer
integer LOAD = 2; // load an entry from the list
integer PARSE = 3; // parse in a list and return count
integer RESET= 5; // delete all values (reset)
integer FREE = 6;  // ask how much free memory
integer SET = 9; // setting parms

debug(string str)
{
    if(DEBUG==1) llOwnerSay("DEBUG("+(string)BANK+"): "+str);
}

default {

    state_entry()
    {
        string scriptname=llGetScriptName();
        list pieces=llParseString2List(scriptname,[" ","-","."],[]);
        string lastpiece=llList2String(pieces,-1);
        if(llSubStringIndex(llToUpper(scriptname),"DEBUG")>=0) DEBUG=1;
        BANK=(integer)lastpiece;
        if(BANK==0) BANK=1;
        debug("My name is: "+scriptname+" BANK is "+(string)BANK+ " freeMemory: "+(string)llGetFreeMemory());

    }

    // Requests received on std channels
    // id holds the key, str the value
    link_message(integer sender_num, integer bnk, string str, key id){
        if(bnk!=BANK) return;
        string strid=(string)id;
        integer num=(integer)llGetSubString(strid,0,0);
        string akey=llGetSubString(strid,1,-1);
        debug("received id: "+(string)id+" num: "+(string)num+" key: "+(string)akey+" value: "+str);
        string ret="OK";

        if(num==ADD) // aKey contains separator <br>
        {
            buffer=(buffer="")+buffer+str;
            integer founddelim=llSubStringIndex(buffer,akey);
            //if(founddelim<=0) founddelim=llSubStringIndex(buffer,llToUpper(akey));
            while(founddelim>=0)
            {
                string element=llGetSubString(buffer,0,founddelim-1);
                debug("ADD Adding element: "+element);
                values=(values=[])+values+element;
                buffer=llGetSubString(buffer,founddelim+llStringLength(akey),-1);
                founddelim=llSubStringIndex(buffer,akey);
                //if(founddelim<=0) founddelim=llSubStringIndex(buffer,llToUpper(akey));
            }
            llSetObjectDesc("OK");
            //llOwnerSay("PARSER: received: "+str);
        }
        if(num==LOAD)
        {
            string ret=llList2String(values,(integer)akey);
            debug("LOAD returning "+ret);
            llSetObjectDesc(ret);
            return;
        }
        if(num==PARSE)
        {
            if(buffer!="")
            {
                debug("PARSE Adding last element: "+buffer);
                values=(values=[])+values+buffer;
            }

            llSetObjectDesc((string)llGetListLength(values));
        }
        if(num==RESET)
        {
            debug("Resetting script");
            llSetObjectDesc("OK");
            llResetScript();
            return;
        }
        if(num==SET)
        {
            llOwnerSay("Setting "+akey);
            if(akey=="DEBUG") DEBUG=1;
            if(akey=="NODEBUG") DEBUG=0;
            llSetObjectDesc("OK");
            return;
        }
        if(num==FREE)
        {
            // returns free and current # of items
            string ret=(string)llGetFreeMemory();
            llSetObjectDesc(llList2CSV( [ret, llGetListLength(values)] ));
            debug("returning "+ret);
            return;
        }
        return;
    }

}


