% subtes: 

linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

% No hay dos estaciones con el mismo nombre.
% Se pide armar un programa Prolog que a partir de esta información permita consultar:

% estaEn/2: en qué línea está una estación.
estaEn(Linea, Estacion):-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

% distancia/3: dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas: por ejemplo, entre Perú Primera Junta hay 5 estaciones.
distancia(Estacion1, Estacion2, Distancia):- 
    estaEn(Linea, Estacion1), 
    estaEn(Linea, Estacion2), 
    linea(Linea, Estaciones), 
    nth1(Posicion1, Estaciones, Estacion1), 
    nth1(Posicion2, Estaciones, Estacion2), 
    Cantidad is  Posicion2-Posicion1, 
    abs(Cantidad,Distancia ).

% mismaAltura/2: dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), por ejemplo: Pellegrini y Santa Fe están ambas segundas.
mismaAltura(Estacion1, Estacion2):- 
    estaEn(Linea1, Estacion1), 
    estaEn(Linea2, Estacion2), 
    linea(Linea1, Estaciones1),
    linea(Linea2, Estaciones2), 
    nth1(Posicion1, Estaciones1, Estacion1), 
    nth1(Posicion2, Estaciones2, Estacion2), 
    not(Posicion1 \= Posicion2).

% granCombinacion/1: se cumple para una combinación de más de dos estaciones.
granCombinacion(Estaciones):-
    combinacion(Estaciones),
    length(Estaciones, Cantidad),
    Cantidad > 2.

% cuantasCombinan/2: dada una línea, relaciona esa línea con la cantidad de estaciones de esa línea que tienen alguna combinación. Por ejemplo, la línea C tiene 3 estaciones que combinan (avMayo, diagNorte e independenciaC).
cuantasCombinan(Linea, Cantidad):- 
    linea(Linea, Estaciones), 
    combinacion(Combinaciones), 
    findall(Elementos, (member(Elementos, Estaciones), combinacion(Combinaciones), member(Elementos, Combinaciones)), ListaElem), 
    length(ListaElem, Cantidad).

% lineaMasLarga/1: es verdadero para la línea con más estaciones.
lineaMasLarga(Linea):-
    linea(Linea, Estaciones1),
    length(Estaciones1, Longitud1),
    not((
        linea(Linea2, Estaciones2), 
        Linea \= Linea2,
        length(Estaciones2, Longitud2),
        Longitud2 > Longitud1
 )).

% viajeFacil/2: dadas dos estaciones, si puedo llegar fácil de una a la otra; esto es, si están en la misma línea, o bien puedo llegar con una sola combinación.

% cuando esta en la misma linea
viajeFacil(Estacion1, Estacion2):- 
    estaEn(Linea, Estacion1),
    estaEn(Linea, Estacion2),
    Estacion1 \= Estacion2.

% cuando es combinacion 
viajeFacil(Estacion1, Estacion2):- 
    combinacion(Estaciones),
    member(Unaestacion, Estaciones),
    member(Otraestacion,Estaciones),
    Estacion1 \= Estacion2,
    estaEn(Linea1, Estacion1),
    estaEn(Linea2, Estacion2),
    Linea1 \= Linea2, 
    estaEn(Linea1,Unaestacion),
    estaEn(Linea2, Otraestacion),
    Unaestacion \= Otraestacion.

