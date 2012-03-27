// pfText example
// Copyright 2007- 2009 Torrid Luna <torrid@primforge.com> http://primforge.com/
// https://wiki.secondlife.com/wiki/Project:Copyrights#Contributing_to_the_Wiki
 
default{
    state_entry(){
        llListen((integer)llGetObjectDesc(), "", NULL_KEY, "");
    }
    listen(integer c, string name, key k, string msg){
        // meant for up to 5 prims. Know what you do. 
        msg = llGetSubString(msg + "                      ", 0, 24);
        // llOwnerSay("stringlength: " + (string)llStringLength(msg));
        integer length = (llStringLength(msg) - 1)/ 5 +1;
        integer i;
        for(i=0;i<length;i++){
            string sub = llGetSubString(msg, i*5, ((i+1)*5 - 1));
            llMessageLinked(LINK_THIS, i, sub, NULL_KEY);
        }
    }
}