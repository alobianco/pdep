% Dodain
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain,viernes, 9, 15).
% Lucas
atiende(lucas, martes, 10, 20).
% Juan C
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingo, 18, 22).
% Juan FdS
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
% Leo C
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
% Martu
atiende(martu, miercoles, 23, 24).
% Punto 1
% Vale atiende los mismos dias que dodain y juanC
atiende(vale, Dia, HorarioInicial, HorarioFinal):-atiende(dodain, Dia, HorarioInicial, HorarioFinal).
atiende(vale, Dia, HorarioInicial, HorarioFinal):-atiende(juanC, Dia, HorarioInicial, HorarioFinal).
% nadie hace el mismo horario que leoC
% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
% Por principio de universo cerrado no es necesario hacer esto, si no existe es falso y listo.
% Punto 2
quienAtiende(Persona, Dia, Horario):-
    atiende(Persona, Dia, HorarioInicial,HorarioFinal),
    between(HorarioInicial, HorarioFinal, Horario). %Un numero entre 2 rangos


% Punto 3
foreverAlone(Persona, Dia, Horario):-
    atiende(Persona,_,_,_),
    quienAtiende(Persona, Dia, Horario),
    not((quienAtiende(OtraPersona, Dia, Horario), Persona  \= OtraPersona)).

% Punto 4
posibilidadDeAtencion(Dia,Personas):-
    findall(Persona, distinct(Persona, quienAtiende(Persona, Dia,_)), ListaPersonas),
    combinar(ListaPersonas, Personas).

combinar([],[]). % Caso lista vacia
combinar([Persona|PersonasPosibles],[Persona|Personas]):-combinar(PersonasPosibles,Personas). % Esta funcion agarra una lista de cosas y las combina en distintas formas, se llama mecanismo de backtracking de Prolog, permite encontrar todas las soluciones posibles
combinar([_|PersonasPosibles],Personas):-combinar(PersonasPosibles,Personas).

% Punto 5
% dodain hizo las siguientes ventas el lunes 10 de agosto: golosinas por $ 1200, cigarrillos Jockey, golosinas por $ 50
venta(dodain,fecha(10,8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
% dodain hizo las siguientes ventas el miércoles 12 de agosto: 8 bebidas alcohólicas, 1 bebida no-alcohólica, golosinas por $ 10
venta(dodain,fecha(12,8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
% martu hizo las siguientes ventas el miercoles 12 de agosto: golosinas por $ 1000, cigarrillos Chesterfield, Colorado y Parisiennes.
venta(martu,fecha(12,8), [golosinas(1000), cigarrillos([chesterfield,colorado,parisiennes])]).
% lucas hizo las siguientes ventas el martes 11 de agosto: golosinas por $ 600.
venta(lucas,fecha(11,8), [golosinas(600)]).
% lucas hizo las siguientes ventas el martes 18 de agosto: 2 bebidas no-alcohólicas y cigarrillos Derby.
venta(lucas,fecha(18,8), [bebida2(false, 2), cigarrillos(derby)]).

vendedora(Persona):-venta(Persona,_,_).

ventaImportante(golosinas(Precio)):-Precio > 100.
ventaImportante(cigarrillos(Marca)):-length(Marca, Cantidad), Cantidad > 2.
ventaImportante(bebidas(true, _)).
ventaImportante(bebidas(_,Cantidad)):-Cantidad > 5.

personaSuertuda(Persona):-
    vendedora(Persona),
    forall(venta(Persona,_,[Venta|_]),ventaImportante(Venta)).


:-begin_tests(kioskito).

test(atienden_los_viernes, set(Persona = [vale, dodain, juanFdS])):-
    atiende(Persona, viernes, _, _).
    
test(personas_que_atienden_un_dia_puntual_y_hora_puntual, set(Persona = [vale, dodain, leoC])):-
    quienAtiende(Persona, lunes, 14).
    
test(dias_que_atiende_una_persona_en_un_horario_puntual, set(Dia = [lunes, miercoles, viernes])):-
    quienAtiende(vale, Dia, 10).
    
test(una_persona_esta_forever_alone_porque_atiende_sola, set(Persona=[lucas])):-
    foreverAlone(Persona, martes, 19).
    
test(persona_que_no_cumple_un_horario_no_puede_estar_forever_alone, fail):-
    foreverAlone(martu, miercoles, 22).
    
test(posibilidades_de_atencion_en_un_dia_muestra_todas_las_variantes_posibles, set(Personas=[[],[dodain],[dodain,leoC],[dodain,leoC,martu],[dodain,leoC,martu,vale],[dodain,leoC,vale],[dodain,martu],[dodain,martu,vale],[dodain,vale],[leoC],[leoC,martu],[leoC,martu,vale],[leoC,vale],[martu],[martu,vale],[vale]])):-
    posibilidadDeAtencion(miercoles, Personas).
    
test(personas_suertudas, set(Persona = [martu, dodain])):-
    personaSuertuda(Persona).
    
:-end_tests(kioskito).