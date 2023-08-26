% Hechos: sujeto(Nombre, Características, Notas)
sujeto(contu, [olfatear, lavar, "contabilidad hogarenia", saltar], [60, 70, 60]).
sujeto(gastoncito, [olfatear], [100, 30, 20]).
% ...otros hechos...

% Hechos: concurso(Nombre, Restricciones)
concurso(preparacionDeEnsalada, [requisitos([olfatear, saltar, "contabilidad hogarenia"]), notas([0, 0, 0])]).
concurso(revolverBasura, [requisitos([olfatear, correr]), notas([0, 0, 50])]).
% ...otros hechos...

% Predicado para verificar si todos los elementos de Lista1 están en Lista2
todos_elementos_presentes([], _).
todos_elementos_presentes([X|Resto], Lista) :-
    esta_en_lista(X, Lista),
    todos_elementos_presentes(Resto, Lista).

% Predicado para verificar si un sujeto cumple con los requisitos de un concurso
cumple_requisitos_sujeto(Sujeto, Requisitos) :-
    sujeto(Sujeto, CaracteristicasSujeto, _),
    Requisitos = requisitos(CaracteristicasRequeridas),
    todos_elementos_presentes(CaracteristicasRequeridas, CaracteristicasSujeto).

% Predicado para verificar si un sujeto participa en un concurso
participa_en_concurso(Sujeto, Concurso) :-
    concurso(Concurso, Restricciones),
    cumple_requisitos_sujeto(Sujeto, Restricciones).


