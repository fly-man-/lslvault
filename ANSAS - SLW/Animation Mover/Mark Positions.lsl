list animation;
default
{
    state_entry()
    {
        
        llSay(0, "Script running");
        llListen(1000,"",NULL_KEY,"");
        animation=[];
    }
    listen(integer channel,string name, key id, string str)
    {
        //llSay(0,"receiving "+str+ " from "+id);
        list lst=llCSV2List(str);
        string cmd=llList2String(lst,0);
        vector pos=llList2Vector(lst,1);
        rotation rot=llList2Rot(lst,2);
        if(cmd=="SET")
        {
            integer chan=(integer)("0x"+id);
            llSay(0," "+name+","+llList2CSV([chan,pos,rot,id])+",\"");
        
            integer fnd=llListFindList(animation,[id]);
            if(fnd>=0)
            {
                animation=llListReplaceList(animation,[],fnd,fnd+1);
            }
            animation+=[ id, llList2CSV([pos,rot]) ];
        }
    }
    touch_start(integer cnt)
    {
        integer i=0; integer max=llGetListLength(animation);
        for(i=0;i<max;i+=2)
        {
            key id=llList2Key(animation,i);
            string val=(llList2String(animation,i+1));
            integer chan=(integer)("0x"+id);
            
            llSay(0,",\""+llList2CSV([chan,val,id])+"\",\"");
        }
        llSay(0,"\",\"\",");
        
    }
}