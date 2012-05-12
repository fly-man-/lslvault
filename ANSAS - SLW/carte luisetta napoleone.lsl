list carte; list pozzo;
string semi="BCDS"; // bastoni, spade, coppe, ori
string valore="A23456789R"; // Asso ... donna 8, cavallo 9, re
integer stackp=0;

string card(integer j, integer i)
{
    return llGetSubString(valore,j,j)+llGetSubString(semi,i,i);
}
string getseme(integer i)
{
    return llGetSubString(semi,i,i);
}
loadcarte()
{
    carte=[];
    integer i; integer j;
    for(i=0;i<4;i++)
        for(j=0;j<10;j++)
            carte+=[ card(j,i) ];
}
mischiacarte()
{
    list carte2=[];
    integer l;
    for(l=0;l<40;l++)
    {
        integer residual=llGetListLength(carte);
        integer random=(integer)llFrand(residual);
        carte2+=llList2String(carte,random);
        carte=llDeleteSubList(carte,random,random);
    }
    carte=carte2;
}
integer check(string nome, integer r, integer c)
{
    string num=llGetSubString(nome,0,0);
    string seme=llGetSubString(nome,1,1);
    integer s=llSubStringIndex(semi,seme);
    integer n=llSubStringIndex(valore,num);
    llSay(0,"seme: "+seme+" num: "+num+ " s: "+(string)s+" n: "+(string)n);
    if( s==r && n==c) return 1;
    return 0;
}
string get(integer r, integer c)
{
    return llList2String(carte,r*10+c);
}

default
{
    state_entry()
    {
        loadcarte(); mischiacarte(); pozzo=[];
        integer i; integer j; integer z=0;
        for(i=0;i<4;i++)
           for(j=0;j<10;j++)
            {
                integer pos=i*10+2+j;
                string s=llList2String(carte,z); 
                 if(j==9) pozzo+=[s];
                string t=getseme(i); 
                llSetLinkPrimitiveParamsFast( 43-pos, [PRIM_TEXT, llGetSubString(valore,j,j) ,<1,1,1>,1, PRIM_TEXTURE,  ALL_SIDES, "SEME-"+t, <1,1,0>, <0,0,0>, -PI/2]); z++;
            }
            llSetLinkPrimitiveParamsFast(1,[PRIM_TEXT,(string)(4-stackp),<1,1,1>,1,PRIM_TEXTURE,0,llList2String(pozzo,stackp),<1,1,0>,<0,0,0>,-PI/2]);
    }
    touch_start(integer count)
    {
        
        integer x=41-llDetectedLinkNumber(0);
        // llSay(0,(string)(x));
        integer r= x / 10;
        integer c= x % 10;
        llSay(0,(string)r+" "+(string)c+" "+llList2String(carte,x));
        
        string curcard=llList2String(pozzo,stackp);
        llSay(0,"curcard: "+curcard);
        if(check(curcard,r,c)==1)
        llSay(0,"posizione giusta");
        else
        llSay(0,"posizione sbagliata"); 
        
    }
}