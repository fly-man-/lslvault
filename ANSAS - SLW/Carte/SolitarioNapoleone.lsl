list carte; // le carte mischiate (40 valori)
string curcard;
list posizioni; // [ "00",linknum, ecc strided per ordinamento
string semi="BCDS"; // bastoni, spade, coppe, ori
string valore="A23456789R"; // Asso ... donna 8, cavallo 9, re
integer stackp=0;
vector COLOR=<1,1,1>;


// dato 00 torna AB (asso bastoni)
string card(integer j, integer i)
{
    return llGetSubString(valore,j,j)+llGetSubString(semi,i,i);
}
// dato 0 torna B (bastoni)
string getseme(integer i)
{
    return llGetSubString(semi,i,i);
}
// carica tutte le posizioni 00 - 39 assegnandole ai numeri di link
loadposizioni()
{
    integer i; posizioni=[];
    for(i=1;i<=llGetNumberOfPrims();i++)
    {
        posizioni+=[ "P"+llGetLinkName(i), i ];
    }
    posizioni=llListSort(posizioni,2,TRUE);
    //llSay(0,llList2CSV(posizioni));
    
}
// dato 00 torna il link number corrispondente dalla lista posizioni
// computa prima la posizione 0-39 e poi cerca Pxx dentro la lista
integer fngetlink(integer r, integer c)
{
    string pos=(string)(r*10+c);
    if(llStringLength(pos)<2) pos="0"+pos;
    integer i=llListFindList(posizioni,["P"+pos]); 
    return llList2Integer( posizioni, i+1 );
}


// carica le carte iniziali tutti i semi e tutti i valori
loadcarte()
{
    carte=[]; stackp=0;
    integer i; integer j;
    for(i=0;i<4;i++)
        for(j=0;j<10;j++)
            carte+=[ card(j,i) ];
}
// mischia le carte in modo casuale
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
    carte=carte2; carte2=[];
}
integer conta;
// funzione di utilità per cambiare le caratteristiche di una carta
// showcard(0,0,"AB",<1,1,1>,"AB"); mostra la texture AB (asso di bastoni) con dicitura AB soprastante
showcard(integer r,integer c,string testo, vector colore, string texture)
{
    // se chiamata con riga negativa usa il root prim 
    integer p; if(r==-1) p=1; else p=fngetlink(r,c);
    llSetLinkPrimitiveParamsFast( p, [PRIM_TEXT, testo ,colore,1, PRIM_TEXTURE,  ALL_SIDES, texture, <1,1,0>, <0,0,0>, -PI/2]);
}
revealcard(integer r,integer c)
{
    
   
    if(c==9)
    {
        // è un re, quindi deve decrementare lo stack
        llSay(0,"Hai perso una carta :("); showcard(r,c,"",COLOR,curcard);
        stackp++; 
        if(stackp>=4){
            llSay(0,"Gioco finito ");
            state default;
        }
        llSleep(1);
        curcard=llList2String(carte,stackp*10+9); 
        showcard(-1,-1,(string)(4-stackp),COLOR,curcard);
        return;
    }
     // la posizione è giusta fa vedere la carta
    conta++; 
    showcard(r,c,"",COLOR,get(r,c));
    llSleep(1);
    if(conta==36)
    {
        llSay(0,"Hai finito il solitario!!!");
        state default;
    }
    showcard(r,c,"",COLOR,curcard);
    curcard=get(r,c);
    //llSay(0,"nuova curcard: "+curcard);

    showcard(-1,-1,(string)(4-stackp),COLOR,curcard);
}
integer check(string nome, integer r, integer c)
{
    string num=llGetSubString(nome,0,0);
    string seme=llGetSubString(nome,1,1);
    integer s=llSubStringIndex(semi,seme);
    integer n=llSubStringIndex(valore,num);
    //llSay(0,"seme: "+seme+" num: "+num+ " s: "+(string)s+" n: "+(string)n);
    if( s==r && n==c) return 1;
    return 0;
}
string get(integer r, integer c)
{
    //llSay(0,"get("+(string)r+","+(string)c+"): carta "+llList2String(carte,r*10+c));
    return llList2String(carte,r*10+c);
}
default
{
    state_entry()
    {
        llListen(-1,"",NULL_KEY,"");
    }
    touch_start(integer count)
    {
        llDialog(llDetectedKey(0),"Giochi?",["SI"],-1);
    }
    listen(integer channel, string name, key id, string str)
    {
        if(str=="SI") state gioca;
    }
}
state gioca
{
    state_entry()
    {
        loadposizioni(); conta=0;
        loadcarte(); 
        mischiacarte();
        integer r; integer c; integer z=0;
        for(r=0;r<4;r++)
           for(c=0;c<10;c++)
            {
                string s=llList2String(carte,z); 
                string t=getseme(r);
                showcard(r,c,(string)(c+1),COLOR,"SEME-"+t); 
                //showcard(r,c,s,COLOR,s); 
                z++;
            }

            curcard=llList2String(carte,stackp*10+9);
            showcard(-1,-1,(string)(4-stackp),COLOR,curcard);
            llSetTimerEvent(60);
    }
    timer()
    {
        llSay(0,"Nessun tocco per 60 secondi, reinizio");
        state default;
    }
    touch_start(integer count)
    {
        llSetTimerEvent(0);
        llSetTimerEvent(60);
        
        integer touched=llDetectedLinkNumber(0);
       // if(llStringLength(touched)<2) touched="0"+touched;
        integer i; string found="";
/*        for(i=0;i<39;i+=2)
        {
            string link=llList2String(posizioni,i+1);
            if(link==touched) found=llList2String
        }*/
        integer index=llListFindList(posizioni,[ touched ]);
        
        integer rc=(integer)(llGetSubString(llList2String(posizioni,index-1),1,-1));
        //llSay(0,"Touched: "+(string)touched+" Index found: "+(string)rc+" from "+index);
        
        // llSay(0,(string)(x));
        integer r= rc/10;
        integer c= rc%10;
        //llSay(0,(string)r+" "+(string)c+" "+llList2String(carte,rc));
        
        
        //llSay(0,"curcard: "+curcard);
        if(check(curcard,r,c)==1){
        llSay(0,"posizione giusta");
        revealcard(r,c);
        }
        else
        llSay(0,"posizione sbagliata"); 
        
    }
}