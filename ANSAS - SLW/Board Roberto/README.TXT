Questo board ascolta sul canale 0x + llGetOwner (quindi individuale per ogni avatar)
Ci sono 12 pezzi e il tabellone dietro
Nella root di ognuno dei 12 pezzi dovete mettere
* pftext.lsl
* pfclient.lsl
* le due texture rinominate escludendo il .tga
Nel pannello nero dietro dovete mettere BoardScript.lsl

Scrivendo sul canale 9999 modifica lo script se vuoi un altro canale

nome,punteggio1,punteggio2 (punteggio 1 viene usato per ordinare)

esempio: claudio,1,1 (ha risposto esatto un tentativo)
claudio,0,1 (ha risposto sbagliato 1 tentativo)

risponde il pannello che tiene un elenco di avatar e il punteggio relativo
ogni volta che riceve una chiamata siffatta ricomputa la classifica
e dice llSay(101-112) alle singole linee in modo da vedere chiaramente
chi ha risposto esattamente e in quanti tentativi.


