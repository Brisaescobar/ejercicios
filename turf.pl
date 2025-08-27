% base de conocimiento 
% punto 1: pasos al costado
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

caballo(botafogo).
caballo(oldMan).
caballo(energetica).
caballo(matBoy).
caballo(yatasto).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoOro).
gano(matBoy, granPremioCriadores).

% a Botafogo le gusta que le jockey pese menos de 52 kilos o que sea Baratucci
preferencias(botafogo, Jockey):-
    jockey(Jockey,_, Peso),
    Peso < 52.

preferencias(botafogo, baratucci).

% a Old Man le gusta que le jockey sea alguna persona de muchas letras (más de 7), existe el predicado atom_length/2
preferencias(oldMan, Jockey):-
    jockey(Jockey,_,_),
    atom_length(Jockey, CantidadLetras),
    CantidadLetras > 7.

% a Enérgica le gustan todes les jockeys que no le gusten a Botafogo
preferencias(energetica, Jockey):-
    jockey(Jockey,_,_),
    not(preferencias(botafogo, Jockey)).

% a Mat Boy le gusta les jockeys que midan mas de 170 cms
preferencias(matBoy, Jockey):-
    jockey(Jockey, Altura, _),
    Altura > 170.

representa(valdiviesom, ElTute).
representa(falero, ElTute).
representa(lezcano, LasHormigas).
representa(baratucci, ElCharabon).
representa(leguisamo, ElCharabon).

% punto 2: para mi, para vos
prefiereMasDeUnJockey(Caballo):-
    caballo(Caballo),
    preferencias(Caballo, Jockey1),
    preferencias(Caballo, Jockey2),
    Jockey1 \= Jockey2.

% punto 3: no se llama amor 
noPrefiereANingunHockey(Caballo, Representante):-
    caballo(Caballo).




