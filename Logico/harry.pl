%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------PARTE 1--------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

mago(Mago):-
    sangre(Mago,_).

permiteEntrar(Casa,Mago):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

permiteEntrar(slytherin,Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.

% tieneCaracteristica(Mago, Caracteristica)
tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, orgullo).
tieneCaracteristica(harry, amistad).
tieneCaracteristica(harry, inteligencia).

tieneCaracteristica(draco, inteligencia).
tieneCaracteristica(draco, orgullo).

tieneCaracteristica(hermione, inteligencia).
tieneCaracteristica(hermione, orgullo).
tieneCaracteristica(hermione, responsabilidad).
%tieneCaracteristica(hermione, amistad).

caracteristicaBuscada(gryffindor, coraje).
caracteristicaBuscada(slytherin, orgullo).
caracteristicaBuscada(slytherin, inteligencia).
caracteristicaBuscada(ravenclaw, inteligencia).
caracteristicaBuscada(ravenclaw, responsabilidad).
caracteristicaBuscada(hufflepuff, amistad).

tieneCaracterApropiado(Mago, Casa):-
  % todas las caracteristicas buscadas por la casa
  % las tiene ese mago
  casa(Casa),
  mago(Mago),
  forall(caracteristicaBuscada(Casa, Caracteristica),tieneCaracteristica(Mago, Caracteristica)).

% Punto 3 - Con recursividad
odiariaEntrar(harry, slytherin).
odiariaEntrar(draco, hufflepuff).

puedeQuedarSeleccionado(Mago,Casa):-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odiariaEntrar(Mago,Casa)).

puedeQuedarSeleccionado(hermione, gryffindor).

cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago,Magos),tieneCaracteristica(Mago, amistad)).

cadenaDeCasas([Mago1, Mago2| MagosSiguientes]):-
    puedeQuedarSeleccionado(Mago1, Casa),
    puedeQuedarSeleccionado(Mago2, Casa),
    cadenaDeCasas([Mago2|MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------PARTE 2--------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esBuenAlumno(Mago).
