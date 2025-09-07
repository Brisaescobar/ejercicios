jockey(valdiviezo, 155, 52).
jockey(leguizamon, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).
gusta(botafogo, baratucci).
gusta(botafogo, Nombre):- jockey(Nombre, _, Peso), Peso <52.
gusta(oldMan, Nombre):-jockey(Nombre, _,_), atom_length(Nombre, Cantidad), Cantidad >7.
gusta(energica, Nombre):- jockey(Nombre,_,_), not(gusta(botafogo, Nombre)).
gusta(matBoy, Nombre):- jockey(Nombre, Altura,_), Altura > 170.
%gusta(yatasto, Nombre):- not(jockey(_,_,_)).
gano(botafogoyatastogranPremioRepublica).
gano(botafogo, granPremioNacional).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoDeOro).
gano(matBoy, granPremioCriadores).
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).
caballeriza(yatastote, valdiviezo).
caballeriza(elTute, falero).
caballeriza(lasHormigas, lezcano).
caballeriza(elCharabon, baratucci).
caballeriza(elCharabon, legizamon).
premioImportante(granPremioRepublica).
premioImportante(granPremioNacional).
colorDe(botafogo, negro).
colorDe(oldMan, marron).
colorDe(energica, negro).
colorDe(energica, gris).
colorDe(matBoy, marron).
colorDe(matBoy, blanco).
colorDe(yatasto, blanco).
colorDe(yatasto, marron).



conMasDeUno(Caballo):- caballo(Caballo), gusta(Caballo, Jockey1), gusta(Caballo, Jockey2), Jockey1 \= Jockey2. %not(iguales(Jockey1, Jockey2)).
%iguales(Jockey, Jockey).

% le camabie el nombre de caballerizaNo a noPrefiere
noPrefiere(Caballo, Caballeriza) :- caballeriza(Caballeriza, Jockey), caballo(Caballo),
    forall(caballeriza(Caballeriza, Jockey), not(gusta(Caballo, Jockey))). %me olvide de ponerle not(gusta()) despues lo puse
    
piolines(Jockey):- jockey(Jockey,_,_), 
    forall(ganoPremioImportante(Caballo), gusta(Caballo, Jockey)).
    
ganoPremioImportante(Caballo) :- gano(Caballo, Premio), premioImportante(Premio).

%fata el 5 que llegue a pensar en functores como lo hizo pero nunca lo tuve claro (ahora los estudio)

puedeComprar(ColorPreferido, Caballos):- findall(Caballo, colorDe(Caballo, ColorPreferido), CaballosPosibles), combinar(CaballosPosibles, Caballos).
%asi lo hizo el tipo a mi no se me ocurrio 
% |
% v
combinar([],[]).
combinar([_|CaballosPosibles], Caballos) :- combinar(CaballosPosibles, Caballos).
combinar([Caballo|CaballosPosibles], [Caballo|Caballos]) :- combinar(CaballosPosibles, Caballos).
%probe cosas de listas
mezclo([Primero, Segundo| Cola], [Segundo , Primero | Cola]).   
igual([],[]).
mezclo2([Cabeza | Cola1], [Cabeza | Cola2]):- mezclo(Cola1, Cola2).


