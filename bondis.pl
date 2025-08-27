% recorridos GBA
recorrido(17,gba(sur),mitre).
recorrido(24, gba(sur),belgrano).
recorrido(247, gba(sur),onsari).
recorrido(60, gba(norte),maipu).
recorrido(152, gba(norte),olivos).

% recorridos en CABA
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

/*Saber si dos líneas pueden combinarse, que se cumple cuando su recorrido 
pasa por una misma calle dentro de la misma zona*/

puedeCombinarse(Linea1, Linea2):-
    recorrido(Linea1, Zona, Calle),
    recorrido(Linea2, Zona, Calle),
    Linea1 \= Linea2.

/*Conocer cuál es la jurisdicción de una línea, que puede ser o bien nacional, 
que se cumple cuando la misma cruza la General Paz,  o bien provincial, cuando no la cruza. 
Cuando la jurisdicción es provincial nos interesa conocer de qué provincia se trata, si es de buenosAires 
(cualquier parte de GBA se considera de esta provincia) o si es de caba.
Se considera que una línea cruza la General Paz cuando parte de su recorrido pasa por una calle de CABA 
y otra parte por una calle del Gran Buenos Aires (sin importar de qué zona se trate).*/

pasaPorGeneralPaz(Linea):-
    recorrido(Linea,caba, _),
    recorrido(Linea,gba(), _).

pertenceA(caba,gba).
pertenceA(gba(), buenosAires).

jurisdiccionDeLaLinea(Linea, nacional):-
    pasaPorGeneralPaz(Linea).

jurisdiccionDeLaLinea(Linea, provincial(Provincia)):-
     recorrido(Linea,Zona,_),
     pertenceA(Zona, Provincia),
     not(pasaPorGeneralPaz(Linea)).

/*Saber cuál es la calle más transitada de una zona, 
que es por la que pasen mayor cantidad de líneas.*/

cuantasLineasPasan(Calle,Zona,Cantidad):-
    recorrido(_, Zona,Calle),
    findall(Calle, recorrido(_, Zona,Calle), Calles),
    length(Calles, Cantidad).

calleMasTransitada(Calle, Zona):-
    cuantasLineasPasan(Calle, Zona, Cantidad),
    forall((recorrido(_, Zona, OtraCalle), Calle \= OtraCalle), (cuantasLineasPasan(OtraCalle, Zona, CantidadMenor), Cantidad > CantidadMenor)).

/*Saber cuáles son las calles de transbordos en una zona, 
que son aquellas por las que pasan al menos 3 líneas de colectivos, 
y todas son de jurisdicción nacional.*/

calleDeTransbordos(CalleDeTransbordo, Zona):-
    recorrido(_, Zona, CalleDeTransbordo),
    forall(recorrido(Linea, Zona, CalleDeTransbordo), jurisdiccionDeLaLinea(Linea, nacional)),
    cuantasLineasPasan(CalleDeTransbordo, Zona,CantidadLineas),
    CantidadLineas >= 3.

