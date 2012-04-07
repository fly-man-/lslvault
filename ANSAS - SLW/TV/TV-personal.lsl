string prompt="Scegli un video di Margye \"dietro le quinte\" da vedere

	*Ricorda che il caricamento del video può impiegare anche 2-3 minuti abbi pazienza*

		";

//  FUNCTIONS
//  --------------------------------------------------------------
list rearrange(list buttons)
{
	//  This function will return a list of the buttons in the list
	//  so they are in a "Top to Bottom" order, rather then the
	//  "Bottom to Top" order that SL defaults to.
	list reordered=buttons;
	list segment;
	integer total_buttons=llGetListLength(buttons);
	integer rows=total_buttons/3;
	integer remainder=total_buttons%3;
	if(remainder!=0)
	{
		segment=llList2List(reordered,0,remainder - 1);
		reordered=llDeleteSubList(reordered,0,remainder - 1);
		reordered+=segment;
	}
	integer x;
	for(x=0;x<rows - 1;x++)
	{
		segment=llList2List(reordered,0,2);
		reordered=llDeleteSubList(reordered,0,2);
		reordered=llListInsertList(reordered,segment,3*(rows - (1+x)));
	}
	return reordered;
}


list video=[

	"http://opensimita.org/lsl/mp4/PZNthjd-V1U.mp4",
	"http://opensimita.org/lsl/mp4/TxbDY58AGq8.mp4",
	"http://opensimita.org/lsl/mp4/lebEv8_xcLE.mp4",

	"http://opensimita.org/lsl/mp4/IvIesrnhsDg.mp4",
	"http://opensimita.org/lsl/mp4/2W9FMYbDQ6c.mp4",
	"http://opensimita.org/lsl/mp4/lF8uzRFcWJU.mp4",

	"http://opensimita.org/lsl/mp4/ENn2Cg4cGa0.mp4",
	"http://opensimita.org/lsl/mp4/mUq9XNs7wTg.mp4",
	"http://opensimita.org/lsl/mp4/axz3gHVhxgQ.mp4"



		];

list titoli=[ "1.Margye", "2.vari", "3.Fiona", "4.Zogia(1)", "5.Zogia(2)", "6.Salahzar", "7.Finale", "8.Joey", "9.Magic" ];
integer index;
integer channel;

default
{
	state_entry()
	{
		llSetText("Toccami per scegliere un video\n\"Dietro le quinte\" \nfatto da Margye",<1,1,1>,1);
		channel=1000000+(integer)llFrand(1000000);
		llListen(channel,"",NULL_KEY,"");
		titoli=rearrange(titoli);
		video=rearrange(video);
	}
	touch_start(integer count)
	{
		llDialog(llDetectedKey(0),prompt, titoli, channel);
	}

	listen(integer channel, string name, key id, string str)
	{
		llSay(0,"Searching for "+str);
		integer index;
		for(index=0;index<llGetListLength(titoli);index++)
		{
			if(str==llList2String(titoli,index))
			{
				llDialog(id,"Video "+str+" in caricamento...\n aspetta un po' e premi play",[],-1);
				llInstantMessage(id,"Se non vedi il video usa il tuo browser con questa url: "+llList2String(video,index));
				llParcelMediaCommandList( [ PARCEL_MEDIA_COMMAND_TEXTURE, "8b5fec65-8d8d-9dc5-cda8-8fdf2716e361", PARCEL_MEDIA_COMMAND_AGENT, id, PARCEL_MEDIA_COMMAND_URL, llList2String(video,index), PARCEL_MEDIA_COMMAND_AUTO_ALIGN, TRUE, PARCEL_MEDIA_COMMAND_LOOP ]);

			}
		}
	}
}