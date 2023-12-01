% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

% Punto 1 - Es un afano

esUnAfano(Jugador, Rival):-
    jugador(Jugador, RatingJugador,_),
    jugador(Rival, RatingRival, _),
    RatingJugador > 500 + RatingRival.

% Punto 2 - Es efectivo

esEfectivo(Unidad, OtraUnidad):-
    militar(Unidad,_,TipoUnidad),
    militar(OtraUnidad,_,TipoOtraUnidad),
    leGana(TipoUnidad, TipoOtraUnidad).
esEfectivo(samurai, Otra):-
    militar(Otra, _, unica).

leGana(caballeria, arqueria).
leGana(arqueria, infanteria).
leGana(infanteria, piquero).
leGana(piquero, caballeria).

% Punto 3 - alarico
alarico(Jugador):-
    tiene(Jugador,_),
    forall(tiene(Jugador, unidad(Tipo,_)), (militar(Tipo,_,Categoria), Categoria = infanteria)).
    
% Punto 4 - Leonidas
leonidas(Jugador):-
    tiene(Jugador,_),
    forall(tiene(Jugador, unidad(Tipo,_)), (militar(Tipo,_,Categoria), Categoria = piquero)).

% Punto 5 - Nomada
nomada(Jugador):-
    tiene(Jugador,_),
    forall(tiene(Jugador, edificio(Tipo,_)), not(Tipo = casa)).

% Punto 6 - Cuanto Cuesta
cuantoCuesta(Unidad, Precio):-
    militar(Unidad,Precio,_).
cuantoCuesta(Edificio,Precio):-
    edificio(Edificio, Precio).
cuantoCuesta(aldeano, costo(0,50,0)).
cuantoCuesta(carreta, costo(100,0,50)).
cuantoCuesta(urnaMercante, costo(100,0,50)).

% Punto 7 - Produccion / 2
produccion(Unidad, Produccion):-
    aldeano(Unidad, Produccion).
produccion(carreta, produce(0,0,32)).
produccion(urnaMercante, produce(0,0,32)).
produccion(keshik, produce(0,0,10)).


% Punto 8 - Produccion total / 3

recurso(oro).
recurso(madera).
recurso(alimento).

recursoPedido(oro, produce(_,_,Oro), Oro).
recursoPedido(alimento, produce(_,Alimento,_), Alimento).
recursoPedido(madera, produce(Madera,_,_), Madera).

produccionTotal(Jugador, Recurso, TotalRecurso):-
    tiene(Jugador, _),
    recurso(Recurso),
    findall(Total, (tiene(Jugador, _), cantidadTotalPorUnidades(_, Recurso, Total)), ListaTotal),
    sumlist(ListaTotal, TotalRecurso).
    
    

recursoPorUnidad(Unidad, Recurso, Total):-
    produccion(Unidad, Produccion),
    recurso(Recurso),
    recursoPedido(Recurso, Produccion, Total).
%recursoPorUnidad(recurso(Madera, _, _), Madera, Madera).
%recursoPorUnidad(recurso(_, Alimento, _), Alimento, Alimento).
%recursoPorUnidad(recurso(_, _, Oro), Oro, Oro).


cantidadUnidad(Unidad, Cantidad):-
    tiene(_, unidad(Unidad, Cantidad)).
cantidadUnidad(Unidad, Cantidad):-
    tiene(_, edificio(Unidad, Cantidad)).

cantidadTotalPorUnidades(Unidad, Recurso, Total):-
    cantidadUnidad(Unidad,Cantidad),
    recurso(Recurso),
    recursoPorUnidad(Unidad, Recurso, TotalRecurso),
    Total is TotalRecurso * Cantidad.

    
         