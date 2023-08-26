/*
Saltos
En una competencia de saltos, cada competidor puede hacer hasta 5 saltos; a cada salto se le asigna un puntaje de 0 a 10. Se define el predicado puntajes que relaciona cada competidor con los puntajes de sus saltos, p.ej.

puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

Se pide armar un programa Prolog que a partir de esta información permita consultar:
Qué puntaje obtuvo un competidor en un salto, p.ej. qué puntaje obtuvo Hernán en el salto 4 (respuesta: 6).
Si un competidor está descalificado o no. Un competidor está descalificado si hizo más de 5 saltos. En el ejemplo, Julio está descalificado.
Si un competidor clasifica a la final. Un competidor clasifica a la final si la suma de sus puntajes es mayor o igual a 28, o si tiene dos saltos de 8 o más puntos.

Ayuda: investigar predicado nth1/3 y nth0/3 en el prolog.
*/

puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

competidor(Persona):-
    puntajes(Persona,_).

puntajeEnSalto(Persona, Salto, Puntaje):-
    puntajes(Persona, ListaSaltos),
    nth1(Salto, ListaSaltos, Puntaje).

descalificado(Persona):-
    puntajes(Persona, ListaSaltos),
    length(ListaSaltos, TamanioLista),
    TamanioLista > 5.

clasificado(Persona):-
    puntajes(Persona, ListaSaltos),
    not(descalificado(Persona)),
    sum_list(ListaSaltos, SumaTotal),
    SumaTotal >= 28.

clasificado(Persona):-
    puntajes(Persona, ListaSaltos),
    not(descalificado(Persona)),
    include(=<(8), ListaSaltos, NuevaLista),
    length(NuevaLista, Largo),
    Largo >=2.

/*
Subtes
En este ejercicio viene bien usar el predicado nth1/3, que relaciona un número, una lista, y el elemento de la lista en la posición indicada por el número (empezando a contar de 1). P.ej. prueben estas consultas
?- nth1(X,[a,b,c,d,e],d).
?- nth1(4,[a,b,c,d,e],X).
?- nth1(Orden,[a,b,c,d,e],Elem).
?- nth1(X,[a,b,c,d,e],j).
?- nth1(22,[a,b,c,d,e],X).
Tenemos un modelo de la red de subtes, por medio de un predicado linea que relaciona el nombre de la linea con la lista de sus estaciones, en orden. P.ej. (reduciendo las lineas)
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

No hay dos estaciones con el mismo nombre.

Se pide armar un programa Prolog que a partir de esta información permita consultar:
1- En qué linea está una estación, predicado estaEn/2.

2- Dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas, p.ej. entre Perú y Primera Junta hay 5 estaciones. Predicado distancia/3 (relaciona las dos estaciones y la distancia).

3- Dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), p.ej. Independencia C y Jujuy que están las dos cuartas. Predicado mismaAltura/2.

4- Dadas dos estaciones, si puedo llegar fácil de una a la otra, esto es, si están en la misma línea, o bien puedo llegar con una sola combinación. Predicado viajeFacil/2.
*/

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


% estaEn/2 En que linea esta cierta estacion, dada una linea y una estacion
estaEn(Linea, Estacion):-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

% distancia/3 Dos estaciones de la misma linea y a que distancia esta cada una.
distancia(Estacion1, Estacion2, Distancia):-
    estaEn(Linea1,Estacion1),
    estaEn(Linea2,Estacion2),
    Linea1 = Linea2,
    linea(Linea1, Estaciones),
    nth1(Ubicacion1, Estaciones, Estacion1),
    nth1(Ubicacion2, Estaciones, Estacion2),
    distanciaTotal(Ubicacion2, Ubicacion1, Distancia).

distanciaTotal(Ubicacion1, Ubicacion2, Total):-
    (Ubicacion1 >= Ubicacion2 -> Total is Ubicacion1 - Ubicacion2;
     Ubicacion2 > Ubicacion1 -> Total is Ubicacion2 - Ubicacion1).

% mismaAltura/2 Dadas dos estaciones de dos lineas distintas, ver si estan a la misma altura.
mismaAltura(Estacion1, Estacion2):-
    estaEn(Linea1, Estacion1),
    estaEn(Linea2, Estacion2),
    Linea1 \= Linea2,
    linea(Linea1, EstacionesLinea1),
    linea(Linea2, EstacionesLinea2),
    nth1(Ubicacion1, EstacionesLinea1, Estacion1),
    nth1(Ubicacion2, EstacionesLinea2, Estacion2),
    Ubicacion1 = Ubicacion2.


% viajeFacil/2

viajeFacil(EstacionPartida, EstacionLlegada):-
    %linea(Linea1, EstacionPartida),
    %linea(Linea2, EstacionLlegada),
    estaEn(Linea1, EstacionPartida),
    estaEn(Linea2, EstacionLlegada),
    EstacionPartida \= EstacionLlegada,
    Linea1 = Linea2.

viajeFacil(EstacionPartida, EstacionLlegada):-
    estaEn(_, EstacionPartida),
    estaEn(_, EstacionLlegada),
    EstacionPartida \= EstacionLlegada,
    combinacion(ListaEstaciones),
    member(EstacionPartida, ListaEstaciones),
    member(EstacionLlegada, ListaEstaciones).

/*
Viajes
Una agencia de viajes lleva un registro con todos los vuelos que maneja de la siguiente manera:
vuelo(Codigo de vuelo, capacidad en toneladas, [lista de destinos]).
Esta lista de destinos está compuesta de la siguiente manera:
escala(ciudad, tiempo de espera)
tramo(tiempo en vuelo)
Siempre se comienza de una ciudad (escala) y se termina en otra (no puede terminar en el aire al vuelo), con tiempo de vuelo entre medio de las ciudades. Considerar que los viajes son de ida y de vuelta por la misma ruta.

Definir los siguientes predicados; en todos vamos a identificar cada vuelo por su código.

vuelo(ARG845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).
vuelo(MH101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).
vuelo(DLH470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).
vuelo(AAL1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),
escala(paris,0)]).
vuelo(BLE849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).
vuelo(NPO556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).
vuelo(DSM3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

1-tiempoTotalVuelo/2 : Relaciona un vuelo con el tiempo que lleva en total, contando las esperas en las escalas (y eventualmente en el origen y/o destino) más el tiempo de vuelo.

2-escalaAburrida/2 : Relaciona un vuelo con cada una de sus escalas aburridas; una escala es aburrida si hay que esperar mas de 3 horas.

3-ciudadesAburridas/2 : Relaciona un vuelo con la lista de ciudades de sus escalas aburridas.

4- vueloLargo/1: Si un vuelo pasa 10 o más horas en el aire, entonces es un vuelo largo. OJO que dice "en el aire", en este punto no hay que contar las esperas en tierra. conectados/2: Relaciona 2 vuelos si tienen al menos una ciudad en común.

5-bandaDeTres/3: Relaciona 3 vuelos si están conectados, el primero con el segundo, y el segundo con el tercero.

6-distanciaEnEscalas/3: Relaciona dos ciudades que son escalas del mismo vuelo y la cantidad de escalas entre las mismas; si no hay escalas intermedias la distancia es 1. P.ej. París y Berlín están a distancia 1 (por el vuelo BLE849), Berlín y Seúl están a distancia 3 (por el mismo vuelo). No importa de qué vuelo, lo que tiene que pasar es que haya algún vuelo que tenga como escalas a ambas ciudades. Consejo: usar nth1.

7-vueloLento/1: Un vuelo es lento si no es largo, y además cada escala es aburrida.
*/

% escala(ciudad, tiempo de espera)
% tramo(tiempo en vuelo)


% vuelo(Codigo de vuelo, capacidad en toneladas, [lista de destinos]).

%--------------------------------------------------------------------------------------------

/*
TEG!
En vista de que gran parte de las personas (chicos y grandes) abandonan los juegos clásicos por modernos juegos de PC, la juguetería de Lanús Quindimil SRL, decide llevar su negocio al terreno digital para poder competir con las nuevas formas de esparcimiento. Así es como se comunican con nosotros solicitándonos que realicemos el desarrollo de ciertas consultas para un tablero de TEG, que se realizan cada cierto tiempo. Cada vez que se realizan las consultas, vamos a contar con ciertos hechos como los que ejemplificamos a continuación.*/

/* distintos paises */
paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, gobi).
paisContinente(asia, india).
paisContinente(asia, iran).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([espania,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, rojo, 4).
ocupa(chile, rojo, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).


ocupa(Pais, Jugador):- ocupa(Pais, Jugador,_).

/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

/*
Se solicita construir un programa que permita la resolución de las siguientes consultas.
Todos los predicados deben ser inversibles, salvo aclaración explícita en contrario.

1- estaEnContinente/2: Relaciona un jugador y un continente si el jugador ocupa al menos un país en el continente.

2- cantidadPaises/2: Relaciona a un jugador con la cantidad de países que ocupa.

3- ocupaContinente/2: Relaciona un jugador y un continente si el jugador ocupa totalmente al continente.

4- leFaltaMucho/2: Relaciona a un jugador y un continente si al jugador le falta ocupar más de 2 países de dicho continente.

5- sonLimitrofes/2: Relaciona 2 países si son limítrofes.

6- esGroso/1: Un jugador es groso si cumple algunas de estas condiciones:
ocupa todos los países importantes,
ocupa más de 10 países
o tiene más de 50 ejercitos.

7- estaEnElHorno/1: un país está en el horno si todos sus países limítrofes están ocupados por el mismo jugador que no es el mismo que ocupa ese país.

8- esCaotico/1: un continente es caótico si hay más de tres jugadores en el.

9- capoCannoniere/1: es el jugador que tiene ocupado más países.

10- ganadooor/1: un jugador es ganador si logro su objetivo 
*/

% 1 -----------------------------------------------------
estaEnContinente(Jugador, Continente):-
    paisContinente(Continente, Pais),
    ocupa(Pais, Jugador).

% 2 -----------------------------------------------------
cantidadPaises(Jugador, CantidadPaises):-
    objetivo(Jugador, _),
    findall(Pais, ocupa(Pais, Jugador), Paises),
    length(Paises, CantidadPaises).

% 3 -----------------------------------------------------
ocupaContinente(Jugador, Continente):-
    objetivo(Jugador,_),
    continente(Continente),
    forall(paisContinente(Continente,Pais), ocupa(Pais, Jugador)).

% 4 -----------------------------------------------------
leFaltaMucho(Jugador, Continente):-
    continente(Continente),
    objetivo(Jugador,_),
    findall(Pais,(paisContinente(Continente, Pais),not(ocupa(Pais, Jugador))), Paises),
    length(Paises, CantidadPaises),
    CantidadPaises > 2.

% 5 -----------------------------------------------------
% sonLimitrofes/2: Relaciona 2 países si son limítrofes
paisLimitrofe(Pais1, Pais2):-
    ocupa(Pais1, _),
    ocupa(Pais2, _),
    Pais1 \= Pais2,
    limitrofes(ListaPaises),
    member(Pais1, ListaPaises),
    member(Pais2, ListaPaises).

% 6 -----------------------------------------------------
% esGroso/1: Un jugador es groso si cumple algunas de estas condiciones:
% ocupa todos los países importantes,
% ocupa más de 10 países
% o tiene más de 50 ejercitos.

esGroso(Jugador):-
    objetivo(Jugador,_),
    forall(paisImportante(Pais), ocupa(Pais, Jugador)).

esGroso(Jugador):-
    objetivo(Jugador,_),
    cantidadPaises(Jugador, CantidadPaises),
    CantidadPaises >= 10.

esGroso(Jugador):-
    objetivo(Jugador, _),
    findall(Cantidad, ocupa(_, Jugador, Cantidad), CantidadEjercitos),
    sum_list(CantidadEjercitos, CantidadTotal),
    CantidadTotal >= 50.

% 6 -----------------------------------------------------
% estaEnElHorno/1 un país está en el horno si todos sus países limítrofes están ocupados por el mismo jugador que no es el mismo que ocupa ese país.

estaEnElHorno(Pais):-
    ocupa(Pais,_),
    %ocupa(PaisLimitrofe,_),
    objetivo(Jugador,_),
    todosPaisesLimitrofes(Pais, ListaPaises),
    maplist(ocupa, Jugador, ListaPaises).


todosPaisesLimitrofes(Pais, ListaPaises):-
    ocupa(Pais,_),
    findall(PaisLimitrofe, paisLimitrofe(Pais, PaisLimitrofe),ListaPaises).

ocupaLista([], []).
ocupaLista([Jugador|ListaJugador], [Pais|ListaPaises]):-
    objetivo(Jugador,_),
    ocupa(Jugador, Pais),
    ocupaLista(ListaJugador, ListaPaises).
    
