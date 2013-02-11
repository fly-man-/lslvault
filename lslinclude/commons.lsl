string  myKey   = "12345678900000000000000000000000"; // 128-bit key in hex
string  myIV    = "89ABCDEF0123456789ABCDEF01234567";

string tstamp() {
    string s=llGetTimestamp();
    return llGetSubString(s,0,9)+" "+llGetSubString(s,11,22);
}

// LATEST
#define HUD_CHANNEL 400
#define BOARD_CHANNEL 401
#define SCREEN_CHANNEL 402
#define CART_CHANNEL 403

#define REQUEST_CHANNEL -2 // channel where to send requests to http server
#define RESPONSE_CHANNEL -3 // channel where to send response for http requests
#define DATABASE_CHANNEL -4 // for accessing database functionalities
#define AES_HELPER_CHANNEL 999 // crypting services

integer DEBUG=0;
string STORE="1";
debug(string x)
{
    if(DEBUG==1) llOwnerSay(tstamp()+" "+llGetScriptName()+"@"+x);
}
string parseParams(integer n)
{
    return llList2String(llParseStringKeepNulls(llGetObjectDesc(),["-"],[]),n);
    
}
#define INITDEBUG DEBUG=(integer)parseParams(3); STORE=parseParams(0);
#define notify_idle llSetText("-",<1,1,1>,1)
#define notify_crypt llSetText("--C--",<1,1,0>,1)
#define notify_http llSetText("--H--",<0,0,1>,1)
#define notify_init llSetText("--@--",<0.5,0.5,0.5>,1)
#define notify_gps llSetText("--G--",<0.8,0.8,0.8>,1)
#define notify_work llSetText("--W--",<0.8,0.1,0.1>,1)

// Returns a new string replacing all instances of old with new starting at pos in source.
// A pos of 0 would begin replacing old with new at the beginning of source.
// A pos of 10 would begin replacing old with new at the 10th character of source.
string StringReplace(integer pos, string source, string old, string new)
{
    string str = source;
    string pre = "";
    if (pos > 0)
    {
        pre = llGetSubString(source, 0, pos - 1);
        str = llGetSubString(source, pos, -1);
    }
    integer len = llStringLength(old);
    integer index = llSubStringIndex(str, old);
    while (index > -1)
    {
        str = llInsertString(llDeleteSubString(str, index, index + len - 1), index, new);
        index = llSubStringIndex(str, old);
    }
    return pre + str;
}
integer iSHOWN=0;
showhud(){
    llSetPos(SHOWN);
    iSHOWN=1;
}
hidehud(){
    llSetPos(HIDDEN);
    iSHOWN=0;
}
togglehud()
{
    iSHOWN=1-iSHOWN;
    if(iSHOWN==1) showhud(); else hidehud();
}


info(string str)
{
    // sessionid|tstamp|message
    string msg=StringReplace(0,str,"|","_");
    llMessageLinked(LINK_SET,REQUEST_CHANNEL,"0|LOG|"+session+"|"+tstamp()+"|"+msg,"");
}
