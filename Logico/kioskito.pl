% Punto 1 
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale,Dias, HorarioInicio, HorarioFin):-
    atiende(dodain, Dias, HorarioInicio, HorarioFin).

atiende(vale,Dias, HorarioInicio, HorarioFin):-
    atiende(juanC, Dias, HorarioInicio, HorarioFin).

% Por universo cerrado, todo lo que no es Verdadero no se coloca
% Por ejemplo si maiu esta pensando, no esta atendiendo en este momento, por eso no es un hecho, lo mismo que decir que nadie atiende en el mismo horario que leoC

% Punto 2 - Quien atiende
quienAtiende(Persona, Dia, Horario):-
    atiende(Persona, Dia, HorarioInicio, HorarioFin),
    between(HorarioInicio, HorarioFin, Horario).
    
% Punto 3 - Forever Alone
foreverAlone(Persona, Dia, Horario):-
    quienAtiende(Persona, Dia, Horario),
    not((quienAtiende(OtraPersona, Dia, Horario), Persona \= OtraPersona)).

% Punto 4: posibilidades de atención (3 puntos / 1 punto)
% Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko
% en algún momento de ese día.

posibilidadesDeAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona,quienAtiende(Persona, Dia,_)), ListaPersonas),
    combinar(ListaPersonas,Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-
    combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-
    combinar(PersonasPosibles, Personas).

% Qué conceptos en conjunto resuelven este requerimiento
% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles
  
% Punto 5: ventas / suertudas (4 puntos)

% golosinas, en cuyo caso registramos el valor en plata
% cigarrillos, de los cuales registramos todas las marcas de cigarrillos que se vendieron (ej: Marlboro y Particulares)
% bebidas, en cuyo caso registramos si son alcohólicas y la cantidad

%vendio(NombreVendedor, fecha(Dia, Mes), [Ventas])).
vendio(dodain, fecha(10, 8), [golosinas(1200),cigarrillos([jockey]),golosinas(50)]).
vendio(dodain, fecha(12, 8), [bebidas(alcoholica, 8),bebidas(noAlcoholica, 1),golosinas(10)]).

vendio(martu, fecha(12, 8), [golosinas(1000),cigarrillos([chesterfield,colorado,parisienne])]).

vendio(lucas, fecha(11, 8), [golosinas(600)]).
vendio(lucas, fecha(18, 8), [bebidas(noAlcoholica,2),cigarrillos([derby])]).

vendedora(Persona):-vendio(Persona,_,_).

ventaImportante(golosinas(Precio)):- Precio > 100.
ventaImportante(cigarrillos(Marcas)):- length(Marcas, CantidadVendidas), CantidadVendidas > 2.
ventaImportante(bebidas(alcoholica, _)).
ventaImportante(bebidas(_, Cantidad)):- Cantidad > 5.

suertuda(Persona):-
    vendedora(Persona),
    forall(vendio(Persona, _, [Venta|_]), ventaImportante(Venta)).





