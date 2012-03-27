// pfText 
// Copyright 2007- 2009 Torrid Luna <torrid@primforge.com> http://primforge.com/
// https://wiki.secondlife.com/wiki/Project:Copyrights#Contributing_to_the_Wiki
 
string showable;
list chartextures;
list faces = [1,6,4,7,3];
 
list offsets = [<0.12, 0.1, 0>, <0.037, 0, 0>, <0.05, 0.1, 0>, <0,0,0>, <-0.74, 0.1, 0>, <0.244, 0, 0>, <0.05, 0.1, 0>, <0,0,0>, <0.12, 0.1, 0>, <-0.037, 0, 0>];
 
 
default{
    state_entry(){
 
        showable = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        showable += "[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~·";
        showable += "\n\n\n\n";
        showable +="ÄäÖöÜüß?ÅåAaÆæ??CcÇĞğdEeHh??LlNnÑñ??ÓóÕõ";
        showable +="ŒœØø\n\n??T???ŞşUuŸÿİı";
 
        chartextures = ["f8638022-4e35-d9de-053b-072b3cdd31ce", "d68b35a5-8f3d-b19c-6455-fd1d2bc9521b"];
 
 llMessageLinked(LINK_THIS,0,"bbbbb",NULL_KEY);
 
    }
    link_message(integer sender, integer num, string str, key id){
        integer i;
        list alletters;
        for(i=0;i<5;i++){
            string thischar = llGetSubString(str, i,i);
            integer charindex = llSubStringIndex(showable, thischar);
 
            integer row = charindex / 10;
            integer col = charindex % 10;
 
            vector offset;
//if (i==2) { offset= <-0.378 + 0.1 * col, 0.45 - 0.1 * row, 0.0>; llSay(0,(string)offset);}
//else
             offset = <-0.45 + 0.1 * col, 0.45 - 0.1 * row, 0.0>;
 
            key texture = llList2Key(chartextures, charindex / 100);
            integer face = llList2Integer(faces, i);
 
            vector offset1 = llList2Vector(offsets, i*2);
            vector offset2 = llList2Vector(offsets, i*2 +1);
 
            //llSetPrimitiveParams([PRIM_TEXTURE, face, texture, offset1, offset + offset2, PI]);
            alletters += [PRIM_TEXTURE, face, texture, offset1, offset + offset2, PI];
        }
        llSetLinkPrimitiveParamsFast(num+1, alletters);
    }
}