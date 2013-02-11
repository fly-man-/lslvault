list rearrange(list buttons)
{
    
    list reordered=buttons;
    list segment;

    
    integer total_buttons= (buttons != []); 

    
    integer rows=total_buttons/3;

    
    
    integer remainder=total_buttons % 3;
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

