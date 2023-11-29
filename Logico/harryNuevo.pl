%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------PARTE 1--------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

casa(ravenclaw).
casa(slytherin).
casa(gryffindor).
casa(hufflepuff).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(neville, pura).
sangre(luna, pura).

mago(Mago):-
    sangre(Mago, _).

odiariaEntrar(harry, slytherin).
odiariaEntrar(draco, hufflepuff).

caracteristica(harry, coraje).
caracteristica(harry, amistad).
caracteristica(harry, orgullo).
caracteristica(harry, inteligencia).
caracteristica(draco, orgullo).
caracteristica(draco, inteligencia).
caracteristica(hermione, inteligencia).
caracteristica(hermione, orgullo).
caracteristica(hermione, responsabilidad).
caracteristica(luna, amistad).
caracteristica(luna, inteligencia).
caracteristica(luna, responsabilidad).



caracteristicaBuscada(gryffindor, coraje).
caracteristicaBuscada(slytherin, orgullo).
caracteristicaBuscada(slytherin, inteligencia).
caracteristicaBuscada(ravenclaw, inteligencia).
caracteristicaBuscada(ravenclaw, responsabilidad).
caracteristicaBuscada(hufflepuff, amistad).

permiteEntrar(Casa,Mago):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

permiteEntrar(slytherin,Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.

tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    forall(caracteristicaBuscada(Casa, Caracteristica),caracteristica(Mago, Caracteristica)).
%Para todas las caracteristicas que busca una casa, las cumple las caracteristicas que tiene un mago

puedeQuedarSeleccionado(Mago, Casa):-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odiariaEntrar(Mago, Casa)).

puedeQuedarSeleccionado(hermione, gryffindor).


cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago,Magos), caracteristica(Mago, amistad)).

cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    puedeQuedarSeleccionado(Mago1, Casa),
    puedeQuedarSeleccionado(Mago2, Casa),
    cadenaDeCasas([Mago2 | MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------PARTE 2--------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
esDe(cedric, hufflepuff).

hizo(harry, fueraDeCama).
hizo(hermione, fueA(tercerPiso)).
hizo(hermione, fueA(seccionRestringida)).
hizo(harry, fueA(bosque)).
hizo(harry, fueA(tercerPiso)).
hizo(draco, fueA(mazmorras)).
hizo(ron, buenaAccion(ganoAjedrezMagico, 50)).
hizo(hermione, buenaAccion(salvarASusAmigos,50)).
hizo(harry, buenaAccion(derrotarAVoldemort, 60)).
hizo(cedric, buenaAccion(comproFalopa,1000)).

hizo(hermione, respondePregunta(dondeSeEncuentraUnBezoar, snape, 20)).
hizo(hermione, respondePregunta(hacerFlotarUnaPluma, flitwick, 25)).

puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(fueA(Lugar), PuntajeQueGenera):-
    lugarProhibido(Lugar, Puntaje),
    PuntajeQueGenera is Puntaje * -1.
puntajeQueGenera(buenaAccion(_,Puntaje), Puntaje).
puntajeQueGenera(respondePregunta(_,Profesor, Dificultad), Puntaje):-
    Profesor \= snape,
    Puntaje is Dificultad.
puntajeQueGenera(respondePregunta(_, snape, Dificultad), Puntaje):-
    Puntaje is Dificultad // 2.

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

hizoAlgunaAccion(Mago):-
    hizo(Mago,_).

hizoAlgoMalo(Mago):-
    hizo(Mago,Accion),
    puntajeQueGenera(Accion, Puntos),
    Puntos < 0.

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

esAccionRecurrente(Accion):-
    hizo(Mago, Accion),
    hizo(OtroMago, Accion),
    Mago \= OtroMago.


puntajeTotalCasa(Casa, PuntajeTotal):-
    casa(Casa),
    findall(Puntos, 
        (esDe(Mago, Casa), puntosQueObtuvo(Mago, _, Puntos)), 
        ListaPuntos),
    sum_list(ListaPuntos, PuntajeTotal).

puntosQueObtuvo(Mago, Accion, Puntos):-
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntos).

casaGanadora(Casa):-
    puntajeTotalCasa(Casa, PuntajeMayor),
    forall((puntajeTotalCasa(OtraCasa, PuntajeMenor), Casa \= OtraCasa),
     PuntajeMayor > PuntajeMenor).

/*Otra forma de hacer casaGanadora
casaGanadora(Casa):-
    puntajeTotalCasa(Casa, PuntajeCasa),
    not((puntajeTotalCasa(_,OtroPuntaje), OtroPuntaje > PuntajeCasa)).

Esta dice "No (not) existe otra casa con puntaje mayor"
*/


    