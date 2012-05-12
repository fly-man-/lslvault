vector pos;
rotation rot;

go()
{
	llSensor("I"+llGetObjectName(),NULL_KEY,PASSIVE | SCRIPTED, 10,2*PI);

}

default
{
	state_entry()
	{
		pos=llGetPos(); rot=llGetRot();
		llListen(20,"",NULL_KEY,"");
	}
	listen(integer channel, string name, key id, string str)
	{
		if(str=="GO"){
			llSleep(llFrand(2));
			go();
			return;
		}
		if(str=="BACK")
		{
			llSetPrimitiveParams([ PRIM_POSITION, pos, PRIM_ROTATION, rot]);
			return;
		}
	}
	touch_start(integer cnt)
	{
		go();
	}
	sensor(integer cnt)
	{
		vector newpos=llDetectedPos(0)+<0,0,.2>;
		rotation newrot=llDetectedRot(0);
		if(llVecDist(llGetPos(),newpos)<0.1) {
			newpos=pos;
			newrot=rot;
		}
		llSetPrimitiveParams([PRIM_POSITION, newpos, PRIM_ROTATION, newrot]);
	}
}