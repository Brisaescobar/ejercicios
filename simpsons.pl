% Base de conocimiento:
esPadre(abe, abbie).
esPadre(abe, homero).
esPadre(abe, herbert).
esPadre(clancy, marge).
esPadre(clancy, patty).
esPadre(clancy, selma).
esPadre(homero, bart).
esPadre(homero, hugo).
esPadre(homero, lisa).
esPadre(homero, maggie).
esMadre(edwina, abbie).
esMadre(mona, homero).
esMadre(gaby, herbert).
esMadre(jacqueline, marge).
esMadre(jacqueline, patty).
esMadre(jacqueline, selma).
esMadre(marge, bart).
esMadre(marge, hugo).
esMadre(marge, lisa).
esMadre(marge, maggie).
esMadre(selma, ling).

% Otros: cuñados/suegros/consuegros/yernos/nueras/primos

% tieneHijo/1: Nos dice si un personaje tiene un hijo o hija.

 progenitor(Personaje):- 
    esPadre(Personaje,_).

progenitor(Personaje):-
    esMadre(Personaje,_).

tieneHijo(Padre):- 
    esPadre(Padre, _).

tieneHijo(Madre):-
    esMadre(Madre, _).

% hermanos/2: Relaciona a dos personajes cuando estos comparten madre y padre.

sonHermanos(Hijo1, Hijo2):-
    esPadre(Padre, Hijo1),
    esMadre(Madre, Hijo1),
    esPadre(Padre, Hijo2),
    esMadre(Madre, Hijo2),
    Hijo1 \= Hijo2.

% medioHermanos/2: Relaciona a dos personajes cuando estos comparten madre o padre.

compartenPadre(Hijo1, Hijo2):-
    esPadre(Padre, Hijo1),
    esPadre(Padre, Hijo2),
    Hijo1 \= Hijo2.

compartenMadre(Hijo1,Hijo2):-
     esMadre(Madre, Hijo1),
     esMadre(Madre, Hijo2),
    Hijo1 \= Hijo2.

sonMedioHermanos(Hijo1, Hijo2):-
    compartenPadre(Hijo1, Hijo2),
    not(compartenMadre(Hijo1, Hijo2)).

sonMedioHermanos(Hijo1, Hijo2):-
    compartenMadre(Hijo1, Hijo2),
    not(compartenPadre(Hijo1, Hijo2)).

% tioDe/2: Relaciona a un personaje con su sobrino. Generalmente, también se le llama tío a la pareja del tío de sangre.

esTioDe(Tio, Sobrino):-
    progenitor(Progenitor),
    sonHermanos(Tio, Progenitor),
    (esPadre(Progenitor, Sobrino); esMadre(Progenitor, Sobrino)).

esTioDe(Tio, Sobrino):-
    progenitor(Progenitor),
    sonMedioHermanos(Tio, Progenitor),
    (esPadre(Progenitor, Sobrino); esMadre(Progenitor, Sobrino)).

% abueloMultiple/1: Nos dice si alguien es abuelo de al menos dos nietos.
esAbueloMultiple(Abuelo):-
    progenitor(Progenitor),
    (esPadre(Abuelo, Progenitor); esMadre(Abuelo, Progenitor)),
    (esPadre(Progenitor, Nieto1); esMadre(Progenitor, Nieto1)),
    (esPadre(Progenitor, Nieto2); esMadre(Progenitor, Nieto2)),
    Nieto1 \= Nieto2.

% descendiente/2: Relaciona a dos personajes, en donde uno desciende del otro a través de una cantidad no predeterminada de generaciones. Por ejemplo, bart es descendiente de homero, de abe y también de sven simpson.

 descendiente(Antecedente, Sucesor):-
    (esPadre(Antecedente, Sucesor); esMadre(Antecedente, Sucesor)).

descendiente(Antecedente, Sucesor):-
    esAbuelo(Antecedente, Sucesor).
    
esAbuelo(Abuelo, Nieto):-
    esPadre(Abuelo, Progenitor),
    esPadre(Progenitor, Nieto).
    
esAbuelo(Abuelo, Nieto):-
    esMadre(Abuelo, Progenitor),
    esMadre(Progenitor, Nieto).

% antecedente el padre del sucesor o que el antecedente sea el abuelo del sucesor 

