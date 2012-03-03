Questo board ascolta sul canale 0x + llGetOwner (quindi individuale per ogni avatar)
Ci sono 12 pezzi e il tabellone dietro
Nella root di ognuno dei 12 pezzi dovete mettere
* pftext.lsl
* pfclient.lsl
* le due texture rinominate escludendo il .tga
Nel pannello nero dietro dovete mettere BoardScript.lsl

Scrivendo sul canale 0x+llGetOwner

nome,punteggio

risponde il pannello che tiene un elenco di avatar e il punteggio relativo
ogni volta che riceve una chiamata siffatta ricomputa la classifica
e dice llSay(101-112) alle singole linee cosa devono visualizzare
