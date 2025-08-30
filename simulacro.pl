% Base de conocimiento
% persona(Nombre, Edad, Genero).
%interesDeUnaPersona(Nombre, [Generos], EdadMinima, EdadMaxima, [Gustos], [Disgustos]).
%indiceDeAmor(Persona1, Persona2, Valor).

% Ejemplos de persona:
persona(juan, 15, masculino).
persona(maria, 23, femenino).
persona(lucas, 30, masculino).
persona(ana, 28, femenino).
persona(pedro, 35, masculino).
persona(luisa, 27, femenino).

% Interes de una persona
interesDeUnaPersona(juan, [femenino], 20, 30, [cine, musica, futbol], [lectura]).
interesDeUnaPersona(maria, [masculino], 22, 35, [cine, lectura, musica], [futbol]).
interesDeUnaPersona(lucas, [femenino], 25, 32, [futbol, viajes, series], [arte]).
interesDeUnaPersona(ana, [masculino], 25, 35, [viajes, musica, arte], [series]).
interesDeUnaPersona(pedro, [femenino], 20, 40, [cine, asado, futbol], [lectura]).
interesDeUnaPersona(luisa, [masculino], 23, 33, [musica, arte, viajes], [futbol]).

% Indice de amor
indiceDeAmor(juan, maria, 9).
indiceDeAmor(maria, juan, 8).
indiceDeAmor(juan, maria, 7).
indiceDeAmor(maria, juan, 6).

% Ana nunca respondio -> ghostea a lucas
indiceDeAmor(lucas, ana, 9).
indiceDeAmor(ana, lucas, 8).
indiceDeAmor(lucas, ana, 10).

% Luisa siente mas -> desbalance
indiceDeAmor(pedro, luisa, 3).
indiceDeAmor(pedro, luisa, 2).
indiceDeAmor(luisa, pedro, 9).

%------------------------------------------------------------------------------------------------

% Perfil incompleto 

perfilIncompleto(Persona) :-
    interesDeUnaPersona(_, _, _, _,Gustos, Disgustos),
    length(Gustos, CantidadDeGustos),
    CantidadDeGustos < 5,
    length(Disgustos, CantidadDeDisgustos),
    CantidadDeDisgustos < 5.

perfilIncompleto(Persona) :-
    persona(_, Edad, _),
    Edad < 18.

% Es alma libre 

esAlmaLibre(Persona) :-
    persona(_, _, Genero),
    interesDeUnaPersona(_, Generos, _, _, _, _),
    forall(persona(_, _, Genero), member(Genero, Generos)).

esAlmaLibre(Persona):-
    interesDeUnaPersona(_, _, EdadMinima, EdadMaxima, _, _),
    EdadMaxima - EdadMinima > 30.

% Quiere la Herencia 

quiereLaHerencia(Persona) :-
    persona(_, Edad, _),
    interesDeUnaPersona(_, _, EdadMinima, _, _, _),
    Edad >= EdadMinima + 30.

% Es indeseable 

esIndeseable(Persona) :-
    persona(Nombre, _, _),
    not(esPretendiente(Persona, _)).

% Es pretendiente 

esPretendiente(Persona, Pretendiente) :-
    persona(Persona, _, _),
    persona(Pretendiente, _, GeneroPretendiente),
    coincideGenero(Persona, Pretendiente),
    coincideEdad(Persona, Pretendiente),
    coincideGustos(Persona, Pretendiente).

% delego las condiciones
coincideGenero(Persona, Pretendiente) :-
    persona(Persona, _, Genero),
    interesDeUnaPersona(Pretendiente, Generos, _, _, _, _),
    member(Genero, Generos).

coincideEdad(Persona, Pretendiente) :-
    persona(Persona, Edad, _),
    interesDeUnaPersona(Pretendiente, _, EdadMinima, EdadMaxima, _, _),
    Edad >= EdadMinima,
    Edad =< EdadMaxima.

coincideGustos(Persona, Pretendiente) :-
    persona(Persona, _, _),
    interesDeUnaPersona(Persona, _, _, _,[GustosPersona], _),
    persona(Pretendiente, _, _),
    interesDeUnaPersona(Pretendiente, _, _, _, [GustosPretendiente], _),
    member(PrimerGusto, GustosPersona),
    member(PrimerGusto, GustosPretendiente).

sonIguales(PrimerGusto, PrimerGusto).

% Hay match 

hayMatch(Persona1, Persona2) :-
    esPretendiente(Persona1, Persona2),
    esPretendiente(Persona2, Persona1).

% Triangulo amoroso 

trianguloAmoroso(Persona1, Persona2, Persona3) :-
    esPretendientePeroNoHayMach(Persona1, Persona2),
    esPretendientePeroNoHayMach(Persona3, Persona1),
    esPretendientePeroNoHayMach(Persona2, Persona3).
       
esPretendientePeroNoHayMach(Persona1,Persona2) :-
    esPretendiente(Persona1, Persona2),
    not(hayMatch(Persona1, Persona2)).

% Son el uno para el otro 

sonElUnoParaElOtro(Persona1, Persona2) :-
    hayMatch(Persona1, Persona2),
    noHayGustoQueDisguste(Persona1, Persona2).

noHayGustoQueDisguste(Persona1,Persona2):-
   noHayDisgustos(Persona1, Persona2),
   noHayDisgustos(Persona2, Persona1).
  
noHayDisgustos(Persona1, Persona2) :-
    interesDeUnaPersona(Persona1, _, _, _, GustosPersona1, DisgustosPersona1),
    interesDeUnaPersona(Persona2, _, _, _, GustosPersona2, DisgustosPersona2),
    forall(member(Gustos, GustosPersona1), not(member(Gustos, DisgustosPersona2))).

%  Indice de amor

promedioDeIndiceDeAmor(Persona1, Persona2, Promedio) :-
    findall(Valor, indiceDeAmor(Persona1, Persona2, Valor), Valores),
    sum_list(Valores, Suma), 
    length(Valores, Cantidad),
    Promedio is Suma / Cantidad.

% mas del doble

masDelDoble(Numero1, Numero2) :-
    Doble is Numero1 * 2, 
    Doble < Numero2.

masDelDoble(Numero1, Numero2) :-
    Doble is Numero2 * 2,
    Doble < Numero1.

% desbalance 

desbalance(Persona1, Persona2) :-
    promedioDeIndiceDeAmor(Persona1, Persona2, Promedio1),
    promedioDeIndiceDeAmor(Persona2, Persona1, Promedio2),
    masDelDoble(Promedio1, Promedio2).

% ghostea 

ghostea(Persona1, Persona2) :-
    leEscribioPeroNoResponde(Persona1, Persona2).
    
leEscribioPeroNoResponde(Persona, OtraPersona) :-
    indiceDeAmor(Persona, OtraPersona, _),
    not(indiceDeAmor(OtraPersona, Persona, _)).


