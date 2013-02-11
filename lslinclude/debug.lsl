integer DEBUG=0;

#ifndef TSTAMP
#define TSTAMP
string tstamp() {
    string s=llGetTimestamp();
    return llGetSubString(s,0,9)+" "+llGetSubString(s,11,22);
}
#endif
#define NOTIFY(x) llOwnerSay(tstamp()+" "+llGetScriptName()+"@"+x)
debug(string x)
{
    if(DEBUG==1) NOTIFY(x);
}


