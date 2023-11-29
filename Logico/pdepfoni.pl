% Punto 1 Vacaciones
vacacionesA(dodain, pehuenia).
vacacionesA(dodain, sanMartinDeLosAndes).
vacacionesA(dodain, esquel).
vacacionesA(dodain, sarmiento).
vacacionesA(dodain, camarones).
vacacionesA(dodain, playasDoradas).
vacacionesA(alf, bariloche).
vacacionesA(alf, sanMartinDeLosAndes).
vacacionesA(alf, elBolson).
vacacionesA(nico, marDelPlata).
vacacionesA(vale, calafate).
vacacionesA(vale, elBolson).

vacacionesA(martu, Destino):-
    vacacionesA(nico, Destino).
vacacionesA(martu, Destino):-
    vacacionesA(alf, Destino).

% No justifico una mierda. me parece bonito asi, por extension.


% Punto 2 - Atracciones
% Atracciones - atracion(Ciudad, Atraccion) - vamos a modelar de formas diferentes cada atraccion
% parqueNacional(nombre). - excursion(nombre) - cerro(nombre, altura) - cuerpoAgua(nombre,puedePescar, temperatura)
atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).
atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoAgua(moquehue, sePuedePescar, 14)).
atraccion(pehuenia, cuerpoAgua(alumine, sePuedePescar, 19)).

esLugarCopado(Lugar):-
    atraccion(Lugar, _),
    not(forall(atraccion(Lugar, Atraccion), not(atraccionCopada(Atraccion)))). %Para toda atraccion de un lugar, no existe un lugar copado, si lo niego, existe un lugar copado en los que da false.

atraccionCopada(parqueNacional(_)).
atraccionCopada(excursion(Nombre)):-
    string_length(Nombre, LargoNombre),
    LargoNombre > 7.
atraccionCopada(cerro(Altura)):-
    Altura > 2000.
atraccionCopada(cuerpoAgua(_,sePuedePescar, _)).
atraccionCopada(cuerpoAgua(_,_,Temperatura)):-
    Temperatura > 20.

vacacionesCopadas(Persona):-
    vacacionesA(Persona,_),
    forall(vacacionesA(Persona,Lugares), esLugarCopado(Lugares)).


% Punto 3 - No se cruzaron
seCruzaron(Persona1, Persona2):-
    vacacionesA(Persona1, Lugar),
    vacacionesA(Persona2, Lugar).

noSeCruzaron(Persona1, Persona2):-
    vacacionesA(Persona1,_), vacacionesA(Persona2,_),
    Persona1 \= Persona2,
    not(seCruzaron(Persona1, Persona2)).

% Punto 4 - Vacaciones Gasoleras

% costoDeVida(Destino, Costo).
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(calafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

destinoGasolero(Destino):-
    costoDeVida(Destino,Costo),
    Costo < 160.

vacacionesGasoleras(Persona):-
    vacacionesA(Persona,_),
    forall(vacacionesA(Persona, Destino), destinoGasolero(Destino)).


% Punto 5 - itinerarios Posibles
%Combinar todos los resultados de una lista de lugares a visitar
%Por alguna razon falla cuando fijas la variable "Persona"
itinerariosPosibles(Persona, Lugares):-
    findall(Lugar,distinct(Lugar, vacacionesA(Persona, Lugar)), ListaLugares),
    permutation(ListaLugares, Lugares).


