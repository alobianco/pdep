%resultado(UnPais, GolesDeUnPais, OtroPais, GolesDeOtroPais).
% Paises bajos 3 - 1 Estados unidos
resultado(paises_bajos, 3, estados_unidos, 1). 
% Australia 1 - 2 Argentina
resultado(australia, 1, argentina, 2). 
resultado(polonia, 3, francia, 1).
resultado(inglaterra, 3, senegal, 0).

pronostico(juan, gano(paises_bajos, estados_unidos, 3, 1)).  % 200 Puntos
pronostico(juan, gano(argentina, australia, 3, 0)).          % 100 Puntos
pronostico(juan, empataron(inglaterra, senegal, 0)).         % 0 Puntos
pronostico(gus, gano(estados_unidos, paises_bajos, 1, 0)).   % 0 Puntos
pronostico(gus, gano(japon, croacia, 2, 0)).                 % 0 Puntos
pronostico(lucas, gano(paises_bajos, estados_unidos, 3, 1)). % 200 Puntos
pronostico(lucas, gano(argentina, australia, 2, 0)).         % 100 Puntos
pronostico(lucas, gano(croacia, japon, 1, 0)).               % 0 Puntos

% PUNTO 1
/*
a) jugaron/3
Relaciona dos paises que hayan jugado un partido y la diferencia de goles entre ambos.
*/
resultadoSinLocal(Pais,GolPais, Rival, GolRival):- resultado(Pais, GolPais, Rival, GolRival).
resultadoSinLocal(Pais,GolPais, Rival, GolRival):- resultado(Rival, GolRival, Pais, GolPais).

jugaron(Equipo, Rival, Diferencia):-
    resultadoSinLocal(Equipo, GolEquipo, Rival, GolRival),
    Diferencia is GolEquipo - GolRival.

/*
b) gano/2
Un país le ganó a otro si ambos jugaron y el ganador metió más goles que el otro.
*/
gano(Pais, Rival):-
    jugaron(Pais, Rival, Diferencia),
    Diferencia > 0.

% PUNTO 2
/*
puntosPronostico/2
Cada pronóstico al que se apuesta en el prode vale una cierta cantidad de puntos dependiendo de qué tan acertado fue respecto del resultado del partido.
Un pronóstico es un functor de cualquiera de estas formas:
gano(PaisGanador, PaisPerdedor, GolesGanador, GolesPerdedor).
empataron(UnPais, OtroPais, GolesDeCualquieraDeLosDos).

Si hay un resultado para el partido y:
el pronóstico le pegó a el ganador o a si fue empate y cantidad de goles de ambos, vale 200 puntos.
el pronóstico le pegó al ganador o a si fue empate pero no a la cantidad de goles, vale 100 puntos.
no le pegó al ganador o a si fue empate, vale 0 puntos.
*/

hayResultadoParaPartido(gano(PaisGanador, PaisPerdedor,_,_)):-
    jugaron(PaisGanador, PaisPerdedor,_).
hayResultadoParaPartido(empataron(PaisGanador, PaisPerdedor,_)):-
    jugaron(PaisGanador, PaisPerdedor,_).

puntosPronostico(Pronostico, Puntos):-
    distinct(Pronostico,pronostico(_, Pronostico)),
    hayResultadoParaPartido(Pronostico),
    calcularPuntos(Pronostico, Puntos).

calcularPuntos(Pronostico, 200):-
    lePegoAlGanadorOEmpate(Pronostico),
    lePegoCantidadDeGoles(Pronostico).

calcularPuntos(Pronostico, 100):-
    lePegoAlGanadorOEmpate(Pronostico),
    not(lePegoCantidadDeGoles(Pronostico)).

calcularPuntos(Pronostico, 0):-
    not(lePegoAlGanadorOEmpate(Pronostico)).

lePegoAlGanadorOEmpate(gano(PaisGanador, PaisPerdedor,_,_)):-
    gano(PaisGanador, PaisPerdedor).

lePegoAlGanadorOEmpate(empataron(Pais1, Pais2, Goles)):-
    resultadoSinLocal(Pais1, Goles, Pais2, Goles).

lePegoCantidadDeGoles(gano(PaisGanador, PaisPerdedor, GolesGanador, GolesPerdedor)):-
    resultadoSinLocal(PaisGanador, GolesGanador, PaisPerdedor, GolesPerdedor).

lePegoCantidadDeGoles(empataron(Pais1, Pais2, Goles)):-
    resultadoSinLocal(Pais1, Goles, Pais2, Goles).

/*
invicto/1
Un jugador del prode está invicto si sacó al menos 100 puntos en cada pronóstico que hizo.
Ojo!: los pronósticos de partidos que aún no se jugaron no deberían tenerse en cuenta. Por ejemplo: lucas hizo 3 pronósticos:
Paises Bajos le gana a Estados Unidos 3 a 1
Argentina le gana a Australia 2 a 0
Croacia le gana a Japón 1 a 0
Los primeros 2 valen 200 y 100 puntos respectivamente, y el tercero aún no tiene puntos porque no se jugó. 
Sin embargo, Lucas está invicto porque todos los pronósticos que hizo que tienen puntos vienen cumpliéndose.
gus pronosticó que japón le gana a croacia 2 a 0, pero el resultado ese partido aún no está en la base de conocimientos
*/
invicto(Jugador):-
    distinct(Jugador, pronostico(Jugador,_)),
    forall((pronostico(Jugador, Pronostico), puntosPronostico(Pronostico, Puntos)), Puntos >= 100).

/*
puntaje/2
Relaciona un jugador con el total de puntos que hizo por todos sus pronósticos.
*/
puntaje(Jugador, Puntaje):-
    distinct(Jugador, pronostico(Jugador,_)),
    findall(Puntos, (pronostico(Jugador, Pronostico), puntosPronostico(Pronostico, Puntos)), ListaPuntos),
    sum_list(ListaPuntos, Puntaje).

/*
favorito/1
un país es favorito si todos los pronósticos que se hicieron sobre ese país lo ponen como ganador 
o si todos los partidos que jugo los gano por goleada (por diferencia de al menos 3 goles).
*/
favorito(Pais):-
    estaEnElPronostico(Pais,_),
    forall(estaEnElPronostico(Pais, Pronostico), loDaComoGanador(Pais, Pronostico)).
favorito(Pais):-
    resultadoSinLocal(Pais,_,_,_),
    forall(jugaron(Pais, _, DiferenciaDeGol),DiferenciaDeGol >= 3).

estaEnElPronostico(Pais, gano(Pais, OtroPais, Goles1, Goles2)) :-
    pronostico(_, gano(Pais, OtroPais, Goles1, Goles2)).
estaEnElPronostico(Pais, gano(OtroPais, Pais, Goles1, Goles2)) :-
    pronostico(_, gano(OtroPais, Pais, Goles1, Goles2)).
estaEnElPronostico(Pais, empataron(Pais, OtroPais, Goles)) :-
    pronostico(_, empataron(Pais, OtroPais, Goles)).
estaEnElPronostico(Pais, empataron(OtroPais, Pais, Goles)) :-
    pronostico(_, empataron(OtroPais, Pais, Goles)).

loDaComoGanador(Pais, gano(Pais, _,_,_)).
    
    
    

