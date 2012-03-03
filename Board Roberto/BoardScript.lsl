integer min=101; // min cell to talk
integer max=112; // max cell to talk


list avatarscores=[]; // strided list of avatars and 2 scores
integer CHANNEL=9999;

string pad( string inString, integer len )      //Outputs the string padded to four characters with spaces on the left
{                                                //( or cut to four characters -- pad("01234")="1234")
    //Note: this function uses a clever trick for efficiency
    integer inStringLength = llStringLength( inString );        //The length of the input string
    if ( inStringLength < len )
        return ( llGetSubString( "000000", 0, len - 1 - inStringLength ) + inString );
    else if ( inStringLength == len )
        return inString;
    else
        return llGetSubString( inString, inStringLength - len, inStringLength );    
}

default
{
    state_entry()
    {   integer i;
        for(i=min;i<=max;i++)llSay(i," "); // clear cells
        CHANNEL=9999; // (integer)("0x"+llGetOwner());
        llListen(CHANNEL,"",NULL_KEY,"");
        //llSetTimerEvent(10);
        llSay(0,"Listening on channel "+(string)CHANNEL);
    }
    listen(integer channel,string name,key id,string str)
    {
        //modified=TRUE;
        list score=llCSV2List(str);
        string avatar=llList2String(score,0);
        integer add1=(integer)llList2String(score,1);
        integer add2=(integer)llList2String(score,2);
        integer found=llListFindList(avatarscores,[avatar]);
        integer value1=0; integer value2=0;
        if(found>=0)
        {
            value1= (integer)llList2String(avatarscores,found-2);
            value2= (integer)llList2String(avatarscores,found-1);
            avatarscores=llDeleteSubList(avatarscores,found-2,found);
            
        }
        value1+=add1; value2+=add2;
        
        //llOwnerSay("Adding "+avatar+" "+value);
        avatarscores+=[value1,value2,avatar];
        
        integer i; integer num=min;
        
        avatarscores=llListSort(avatarscores,3,FALSE);
        //llOwnerSay("modified "+llList2CSV(avatarscores));
        for(i=min;i<=max;i++)llSay(i," ");
        for(i=0;i<llGetListLength(avatarscores);i+=3)
        {
            //llOwnerSay("Saying on channel "+(string)num+" "+llList2String(avatarscores,i)+" ["+llList2String(avatarscores,i+1)+"]");
            llSay(num,"["+pad(llList2String(avatarscores,i),2)+"] "+pad(llList2String(avatarscores,i+1),2)+" "+llList2String(avatarscores,i+2));
            num++;
        }
        //modified=FALSE;
    }
}