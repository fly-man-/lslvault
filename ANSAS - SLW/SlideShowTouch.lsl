// Inserisci le texture nell'inventory dell'oggetto nominandole successivamente 01 02 03 etc
// Ad ogni click viene visualizzata la immagine successiva
integer i=-1;
default
{

	touch_start(integer total_number)
	{
		integer number = llGetInventoryNumber(INVENTORY_TEXTURE);
		i++;
		if(i>=number) i=0;

		string name = llGetInventoryName(INVENTORY_TEXTURE, i);
		if (name != "")
			llSetTexture(name, ALL_SIDES);
	}
}