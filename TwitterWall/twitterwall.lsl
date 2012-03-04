integer channel=10;
integer side = 0;
string searchterm="sloodle";
string caption = "Caption";
string title = "Titolo";
setData(string searchTerm,string caption,string title){
         llClearPrimMedia(side);
        string twitterText ="<body><script>";
        twitterText +="new TWTR.Widget({";
        twitterText +="version: 2,";
        twitterText +="type: 'search',";
        twitterText +="search: '"+searchTerm+"',";
        twitterText +="interval: 30000,";
        twitterText +="title: '"+title+"',";
        twitterText +="subject: '"+caption+"',";
        twitterText +="width: 250,";
        twitterText +="height: 300,";
        twitterText +="theme: {";
        twitterText +="shell: {";
        twitterText +="background: '#7c001a',";
        twitterText +="color: '#ffffff'";
        twitterText +="},";
        twitterText +="tweets: {";
        twitterText +="background: '#ffffff',";
        twitterText +="color: '#444444',";
        twitterText +="links: '#1985b5'";
        twitterText +="}";
        twitterText +="},";
        twitterText +="features: {";
        twitterText +="scrollbar: false,";
        twitterText +="loop: true,";
        twitterText +="live: true,";
        twitterText +="hashtags: true,";
        twitterText +="timestamp: true,";
        twitterText +="avatars: true,";
        twitterText +="toptweets: true,";
        twitterText +="behavior: 'default'";
        twitterText +="}";
        twitterText +="}).render().start();";
        twitterText +="</script>";
        string url = "data:text/html,<head><script src=\"http://widgets.twimg.com/j/2/widget.js\"></script></head>";
        
        url+=twitterText+ "</body>";
        llSetPrimMediaParams( side, [ PRIM_MEDIA_CURRENT_URL, url, PRIM_MEDIA_HOME_URL, url, PRIM_MEDIA_FIRST_CLICK_INTERACT, TRUE, PRIM_MEDIA_AUTO_ZOOM, TRUE, PRIM_MEDIA_AUTO_PLAY, TRUE, PRIM_MEDIA_PERMS_INTERACT, PRIM_MEDIA_PERM_OWNER, PRIM_MEDIA_PERMS_CONTROL, PRIM_MEDIA_PERM_NONE ] );
}

string text;


default
{
   // touch_start(integer d){
   
  //}
    state_entry(){
      llListen(channel,"",NULL_KEY,"");
    llClearPrimMedia(side); string message="OpenSim";
     setData(message,"Searching: "+message,"Twitter wall");
       
   }
   listen(integer channel, string name, key id, string message) {
           llClearPrimMedia(side); 
           setData(message,"Searching: "+message,"Twitter wall");
   }
   
     
 
            
    on_rez(integer start_param) {
        llClearPrimMedia(side);                
        // Give the object a starting texture.
        // If we just use llClearPrimMedia here, we get a strange problem where if you click on it before it's ready, autozoom fails until you look away then look back.
       
    } 
                
           
    }
   