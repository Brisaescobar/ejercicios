%base de conocimiento
persona(Nombre, Edad, Genero).
interesDeUnaPersona(Nombre, [Generos], EdadMinima, EdadMaxima, [Gustos], [Disgustos]).

% Perfil incompleto 

perfilIncompleto(Persona):-
    persona(Nombre, Edad, Genero),
    interesDeUnaPersona(_,_,_,_,[Gustos],[Disgustos]),
    length(Gustos, CantidadDeGustos),
    CantidadDeGustos < 5,
    length(Disgustos, CantidadDeDisgustos),
    CantidadDeDisgustos < 5.

perfilIncompleto(Persona):-
    persona(_,Edad,_),
    Edad < 18.

% Es alma libre 

esAlmaLibre(Persona):-
    persona(Nombre, Edad, Genero),
    interesDeUnaPersona(_,[Generos],_,_,_,_),
    forall(persona(_,_,Genero), member(Genero, Generos)).

esAlmaLibre(Persona):-
    persona(Nombre, Edad, Genero),
    interesDeUnaPersona(_,_,EdadMinima,EdadMaxima,_,_),
    EdadMaxima - EdadMinima > 30.

% Quiere la Herencia 

quiereLaHerencia(Persona):-
    persona(Nombre, Edad, Genero),
    interesDeUnaPersona(_,_,EdadMinima,_,_,_),
    Edad >= EdadMinima + 30.

% Es indeseable 

esIndeseable(Persona):-
    persona(Nombre,_, _),
    not(esPretendiente(Persona,_)).

% Es pretendiente 

esPretendiente(Persona, Pretendiente):-
    persona(Persona,_,_),
    persona(Pretendiente,_,GeneroPretendiente),
    coincideGenero(Persona, Pretendiente),
    coincideEdad(Persona, Pretendiente),
    coincideGustos(Persona, Pretendiente).

% delego las condiciones
coincideGenero(Persona, Pretendiente):-
    persona(Persona,_, Genero),
    interesDeUnaPersona(Pretendiente,[Generos],_,_,_,_),
    member(Genero,Generos).

coincideEdad(Persona, Pretendiente):-
    persona(Persona,Edad,_),
    interesDeUnaPersona(Pretendiente,_,EdadMinima,EdadMaxima,_,_),
    Edad >= EdadMinima,
    Edad =< EdadMaxima.

coincideGustos(Persona, Pretendiente):-
    persona(Persona,_,_),
    interesDeUnaPersona(Persona,_,_,_,[GustosPersona],_),
    persona(Pretendiente,_,_),
    interesDeUnaPersona(Pretendiente,_,_,_,[GustosPretendiente],_),
    member(PrimerGusto,GustosPersona),
    member(PrimerGusto,GustosPretendiente).

sonIguales(PrimerGusto, PrimerGusto).

% Hay match 

hayMatch(Persona1, Persona2):-
    esPretendiente(Persona1, Persona2),
    esPretendiente(Persona2, Persona1).

% Triangulo amoroso 

trianguloAmoroso(Persona1, Persona2, Persona3):-
    esPretendientePeroNoHayMach(Persona1, Persona2),
    esPretendientePeroNoHayMach(Persona3, Persona1),
    esPretendientePeroNoHayMach(Persona2, Persona3).
       
esPretendientePeroNoHayMach(Persona1,Persona2):-
    esPretendiente(Persona1,Persona2),
    not(hayMatch(Persona1, Persona2)).

% Son el uno para el otro 

sonElUnoParaElOtro(Persona1, Persona2):-
    hayMatch(Persona1, Persona2).




