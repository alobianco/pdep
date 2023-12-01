% rata(Nombre, Vivienda).
rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).
% cocina(NombrePersona, QueCocina, Experiencia).
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).
% trabajaEn(Restaurante, Persona).
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

% Punto 1

inspeccionSatisfactoria(Restaurante):-
    trabajaEn(Restaurante,_),
    not(rata(_,Restaurante)).

% Punto 2
chef(Empleado, Restaurante):-
    trabajaEn(Restaurante, Empleado),
    cocina(Empleado,_,_).

% Punto 3
chefcito(Rata):-
    rata(Rata,Restaurante),
    trabajaEn(Restaurante, linguini).

% Punto 4
cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.
cocinaBien(remy, _).

% Punto 5
encargadoDe(Persona, Plato, Restaurante):-
    trabajaEn(Restaurante,Persona),
    cocina(Persona,Plato,HabilidadPersona),
    forall(((trabajaEn(Restaurante,_)),cocina(_, Plato, MenorHabilidad)),(HabilidadPersona>=MenorHabilidad)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Platos  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% entrada(Ingredientes).
% principal(Guarnicion, TiempoDeCoccion).
% postre(Calorias).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

% Punto 6 
saludable(Plato):-
    plato(Plato,Dato),
    calorias(Dato, Calorias),
    Calorias < 75.

calorias(entrada(Ingredientes), Calorias):-
    length(Ingredientes, Cantidad),
    Calorias is Cantidad * 15.
    
calorias(principal(Guarnicion, Tiempo), Calorias):-
    CaloriasPrincipal is Tiempo * 5,
    caloriasGuarnicion(Guarnicion, CaloriasGuarnicion),
    Calorias is CaloriasGuarnicion + CaloriasPrincipal.


calorias(postre(Calorias),Calorias).

caloriasGuarnicion(pure, 20).
caloriasGuarnicion(papasFritas, 50).

% Punto 7
criticaPositiva(Restaurante, Critico):-
    trabajaEn(Restaurante,_),
    criterio(Critico, _),
    inspeccionSatisfactoria(Restaurante),
    criterio(Critico, Restaurante).

criterio(antonEgo, Restaurante):-
    trabajaEn(Restaurante,_),
    forall(trabajaEn(Restaurante, Chef),cocinaBien(Chef, ratatouille)).

criterio(christophe, Restaurante):-
    trabajaEn(Restaurante,_),
    findall(Empleado, trabajaEn(Restaurante, Empleado),ListaEmpleados),
    length(ListaEmpleados, CantidadEmpleados),
    CantidadEmpleados > 3.

criterio(cormillot, Restaurante):-
    trabajaEn(Restaurante,_),
    forall(trabajaEn(Restaurante, Chef), (cocina(Chef, Plato,_), saludable(Plato), tieneZanahoria(Plato))).
    
tieneZanahoria(Plato):-
    plato(Plato, entrada(Dato)),
    member(zanahoria, Dato).
    