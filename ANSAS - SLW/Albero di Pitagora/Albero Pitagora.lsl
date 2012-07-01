// based on Opensource script written by Marcus73 Core 2011
// modified by Salahzar Stenvaag to be vertical
vector actual_size;
integer canale=10;
integer listen_handler;
float new_dim;
integer rezzed=0;

rezzer()
{
	//llSay(0,"Trying to rez");
	if(rezzed==1) return;

	// la nuova dimensione ? calcolata dividendo per radice di 2
	new_dim=actual_size.x/llSqrt(2.0);

	// trova la posizione attuale e la rotazione attuale
	vector actual_pos=llGetPos();
	rotation actual_rot=llGetRot();
	vector actual_rot_v=llRot2Euler(actual_rot)*RAD_TO_DEG;

	// rotazione di 45? in senso orario e antiorario
	rotation rot_new1=llEuler2Rot(<-45,0,0>*DEG_TO_RAD);
	rotation rot_new2=llEuler2Rot(<45,0,0>*DEG_TO_RAD);

	// raggio del rettangolo di dimensioni x/2 e x
	float r=llSqrt((actual_size.x/2)*(actual_size.x/2)+(actual_size.x)*(actual_size.x));

	// partiamo da una rotazione di 116? lungo l'asse z
	float angle=(-116-90+180+actual_rot_v.x)*DEG_TO_RAD;
	float xr=actual_pos.x;
	float yr=actual_pos.y+r*llSin(angle);
	float zr=actual_pos.z+r*llCos(angle);

	llRezObject("Object",<xr,yr,zr>,ZERO_VECTOR,rot_new1*actual_rot,0);

	angle=(-64-90+180+actual_rot_v.x)*DEG_TO_RAD;
	xr=actual_pos.x;
	yr=actual_pos.y+r*llSin(angle);
	zr=actual_pos.z+r*llCos(angle);

	llRezObject("Object",<xr,yr,zr>,ZERO_VECTOR,rot_new2*actual_rot,0);
	rezzed=1;

}

default
{
	state_entry()
	{
		integer canale=(integer)("0x"+llGetKey());
		listen_handler=llListen(canale,"",NULL_KEY,"");
		llListen(99,"",NULL_KEY,"");
		actual_size=llGetScale(); //llList2Vector(llGetPrimitiveParams([PRIM_SIZE]),0);
	}

	on_rez(integer n)
	{
		llResetScript();
	}

	listen( integer channel, string name, key id, string message )
	{

		if(channel==99){
			if(message=="DIE")
			{
				llDie();
				return;
			}
			if(message=="REZ")
			{
				rezzer();
				return;
			}
		}
		// llListenRemove(listen_handler);
		float new_dim=(float) message;
		llSetPrimitiveParams([PRIM_SIZE,<new_dim,new_dim,new_dim>]);
		actual_size=llGetScale(); // llList2Vector(llGetPrimitiveParams([PRIM_SIZE]),0);
	}

	touch_start(integer total_number)
	{
		// llListenRemove(listen_handler);
		rezzer();
	}

	object_rez(key id)
	{
		string inventory=llGetInventoryName(INVENTORY_OBJECT,0);
		llGiveInventory(id,inventory);
		llSleep(0.2);
		integer canale=(integer)("0x"+id);
		llRegionSay(canale,(string) new_dim);

	}
}
