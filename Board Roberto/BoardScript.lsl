integer min=1;
integer max=12;

list avatarscores=[]; // strided list of avatars and scores


integer modified=FALSE;
integer CHANNEL;

default
{
    state_entry()
    {   integer i;
        for(i=min;i<=max;i++)llSay(100+i," ");
        CHANNEL=(integer)("0x"+llGetOwner());
        llListen(CHANNEL,"",NULL_KEY,"");
        //llSetTimerEvent(10);
        llSay(0,"Listening on channel "+(string)CHANNEL);
    }
    listen(integer channel,string name,key id,string str)
    {
        modified=TRUE;
        list score=llCSV2List(str);
        string avatar=llList2String(score,0);
        integer add=(integer)llList2String(score,1);
        integer found=llListFindList(avatarscores,[avatar]);
        integer value=0;;
        if(found>=0)
        {
            value= (integer)llList2String(avatarscores,found-1);
            avatarscores=llDeleteSubList(avatarscores,found-1,found);
            
        }
        value+=add;
        
        //llOwnerSay("Adding "+avatar+" "+value);
        avatarscores+=[value,avatar];
        
        integer i; integer num=min;
        
        avatarscores=llListSort(avatarscores,2,FALSE);
        //llOwnerSay("modified "+llList2CSV(avatarscores));
        for(i=min;i<=max;i++)llSay(100+i," ");
        for(i=0;i<llGetListLength(avatarscores);i+=2)
        {
            //llOwnerSay("Saying on channel "+(string)num+" "+llList2String(avatarscores,i)+" ["+llList2String(avatarscores,i+1)+"]");
            llSay(100+num,"["+llList2String(avatarscores,i)+"] "+llList2String(avatarscores,i+1));
            num++;
        }
        //modified=FALSE;
    }
}