float START_TIME = 30.0;
float RUN_LENGTH = 10.0;


list videos=
[
    "Corso","http://www.anitel.org/film/corso1.mov", 40,
    "Flauto Etrusco", "http://www.anitel.org/film/flautoetru.mp4", 40
];

integer i=0;
string curvideo;
string cururl;
integer length;
// integer counter;

getNextVideo()
{
    curvideo=llList2String(videos,i);
    cururl=llList2String(videos,i+1);
    length=llList2Integer(videos,i+2);
    i+=3;
    if(i>=llGetListLength(videos)) i=0;
    llSetText("Playing "+curvideo+" ("+(string)length+"\")",<1,1,1>,1);
    llParcelMediaCommandList( [
            PARCEL_MEDIA_COMMAND_STOP,
            PARCEL_MEDIA_COMMAND_URL, cururl,
            PARCEL_MEDIA_COMMAND_PLAY
//            ,PARCEL_MEDIA_COMMAND_TEXTURE,  texture ] );
]);
    llSetTimerEvent(10);
}
default
{
    state_entry()
    {
        i=0; getNextVideo();
    
        llSay(0,"reset");
    }


    timer()
    {
        //llSetTimerEvent(0);
        length-=10;
        if(length>0)
            llSetText("Playing "+curvideo+" ("+(string)length+"\")",<1,1,1>,1);
        else getNextVideo();
    }
}