// Mini Wave Relay, enabling cross chat with skype and other boxes in various opensim
// and secondlife virtual worlds
//
string url="http://salahzar.dyndns-web.com:8080/"; // where you put the c# executable
string myid;
default
{
	state_entry()
	{
		llRequestURL();
	}

	http_request(key id, string method, string body)
	{
		if (method == URL_REQUEST_GRANTED)
		{
			myid=body;
			llSay(0,"URL: " + body);
			state ready;
		}

	}
}
state ready
{
	state_entry()
	{
		// Register on
		llHTTPRequest(url+"?sender="+llEscapeURL(myid),[],"");
		llListen(0,"",NULL_KEY,"");
	}
	listen(integer channel,string name,key id,string str)
	{
		llHTTPRequest(url+"?sender="+llEscapeURL(myid)+"&message="+llEscapeURL(name+":"+str),[],"");
	}
	http_request(key id, string method, string body)
	{
		if (method == "GET")
		{
			// llSay(0,"called with "+body+ "query string: "+ llGetHTTPHeader(id,"x-query-string"));
			string message=llGetHTTPHeader(id,"x-query-string");
			integer equal=llSubStringIndex(message,"=");

			llSay(0,"[miniwave] "+llGetSubString(message,equal+1,-1));
			llHTTPResponse(id,200,"OK!");


		}
	}
	http_response(key id, integer status,list meta, string body)
	{
		llSay(0,"[miniwave registering] "+body);
	}

}