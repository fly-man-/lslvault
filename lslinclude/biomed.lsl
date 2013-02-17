string  myKey   = "12345678900000000000000000000000"; // 128-bit key in hex
string  myIV    = "89ABCDEF0123456789ABCDEF01234567";


// LATEST
#define HUD_CHANNEL 400
#define BOARD_CHANNEL 401
#define SCREEN_CHANNEL 402
#define CART_CHANNEL 403

#define REQUEST_CHANNEL 202 // channel where to send requests to http server
#define RESPONSE_CHANNEL 203 // channel where to send response for http requests
#define DATABASE_CHANNEL 204 // for accessing database functionalities
#define AES_HELPER_CHANNEL 999 // crypting services

// states of HUD400 
#define STATUS_GETSL "getsl" // getting shopping list
#define STATUS_READY "ready" // next action BEGIN to get Shopping List
#define STATUS_OFF "off" // when checkout has been done HUDs stops working


#define STATUS_WAITCOUNT "waitcount" // waiting for count (when checkout has been asked)
#define STATUS_ASKQUIT "askquit" // asking confirmation for Checkout (ok to quit?)
#define STATUS_LOOKSKU "lookforsku" // looking for sku on database
#define STATUS_ASKING "asking" // an item has been clicked what to do? TAKE/DROP
#define STATUS_SENDEND "sendend" // sent end to TRANSMITTER
#define STATUS_WAITINGCART "waitingcart" // waiting cart for TAKE/DROP
#define STATUS_RUNNING "running" // running state after BEGIN

// commands exchanged
#define CMD_SENTCOUNT "sentcount"
#define CMD_SENTCART "sentcart"



string STORE="1";
#define INITDEBUG DEBUG=(integer)parseParams(3); STORE=parseParams(0);

#define notify_idle llSetText("-",<1,1,1>,1)
#define notify_crypt llSetText("--C--",<1,1,0>,1)
#define notify_http llSetText("--H--",<0,0,1>,1)
#define notify_init llSetText("--@--",<0.5,0.5,0.5>,1)
#define notify_gps llSetText("--G--",<0.8,0.8,0.8>,1)
#define notify_work llSetText("--W--",<0.8,0.1,0.1>,1)

#define GLOSSYWHITE "89eef91f-2f72-4ad7-59d1-828abaf3e434"
#define L2S(s,i) llList2String(s,i)
#define L2I(s,i) llList2Integer(s,i)
#define L2K(s,i) llList2Key(s,i)
#define L2V(s,i) llList2Vector(s,i)

#define MSG(channel,str,id) llMessageLinked(LINK_SET,channel,str,id)
#define SETLINK(link,parms) llSetLinkPrimitiveParamsFast((link),(parms))
#define GETLINK(link,parms) llGetLinkPrimitiveParams(link,parms)
#define WHITE <1,1,1>
#define RED <1,0,0>
#define GREEN <0,1,0>
#define BLUE <0,0,1>
#define PARSE(x,sep) llParseStringKeepNulls(x,[ sep ],[])
#define DUMP(x,sep) llDumpList2String(x,sep)
#define LINKMSG link_message(integer sender, integer channel, string msg, key id)
#define LISTEN listen(integer channel, string name, key id, string str)

#define DEBUGLISTEN if(cmd=="DEBUG") { NOTIFY("Debug on"); DEBUG=1; return; }\
					if(cmd=="NODEBUG") { NOTIFY("Debug off"); DEBUG=0; return; }

#define RESETLISTEN if(cmd=="RESET") { llResetScript(); return; }
string session;

info(string str)
{
    // sessionid|tstamp|message
    string msg=StringReplace(0,str,"|","_");
    llMessageLinked(LINK_SET,REQUEST_CHANNEL,"0|LOG|"+session+"|"+tstamp()+"|"+msg,"");
}


