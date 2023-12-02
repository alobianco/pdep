% puedeCumplir(Persona, Rol): relaciona una persona con un rol que puede cumplir
puedeCumplir(jorge, instrumentista(guitarra)).
puedeCumplir(daniel, instrumentista(guitarra)).
puedeCumplir(daniel, actor(narrador)).
puedeCumplir(daniel, instrumentista(tuba)).
puedeCumplir(daniel, actor(paciente)).
puedeCumplir(marcos, actor(narrador)).
puedeCumplir(marcos, actor(psicologo)).
puedeCumplir(marcos, instrumentista(percusion)).
puedeCumplir(daniel, instrumentista(percusion)).
puedeCumplir(carlos, instrumentista(violin)).
puedeCumplir(carlitos, instrumentista(piano)).
puedeCumplir(daniel, actor(canto)).
puedeCumplir(carlos, actor(canto)).
puedeCumplir(carlitos, actor(canto)).
puedeCumplir(marcos, actor(canto)).
puedeCumplir(jorge, actor(canto)).
puedeCumplir(jorge, instrumentista(bolarmonio)).

% necesita(Sketch, Rol): relaciona un sketch con un rol necesario para interpretarlo.
necesita(payadaDeLaVaca, instrumentista(guitarra)). % Daniel, Jorge
necesita(malPuntuado, actor(narrador)). % Daniel, Marcos
necesita(laBellaYGraciosaMozaMarchoseALavarLaRopa, actor(canto)). % Daniel, Carlos, Carlitos, Marcos, Jorge
necesita(laBellaYGraciosaMozaMarchoseALavarLaRopa, instrumentista(violin)). % Carlos
necesita(laBellaYGraciosaMozaMarchoseALavarLaRopa, instrumentista(tuba)). % Daniel
necesita(lutherapia, actor(paciente)). % Daniel
necesita(lutherapia, actor(psicologo)). % Marcos
necesita(cantataDelAdelantadoDonRodrigoDiazDeCarreras, actor(narrador)). % Daniel, Marcos
necesita(cantataDelAdelantadoDonRodrigoDiazDeCarreras, instrumentista(percusion)). % Daniel, Marcos
necesita(cantataDelAdelantadoDonRodrigoDiazDeCarreras, actor(canto)). % Daniel, Carlos, Carlitos, Marcos, Jorge
necesita(rhapsodyInBalls, instrumentista(bolarmonio)). % Jorge
necesita(rhapsodyInBalls, instrumentista(piano)). % Carlitos

% duracion(Sketch, Duracion):. relaciona un sketch con la duración (aproximada, pero la vamos a tomar como fija) que se necesita para interpretarlo.
duracion(payadaDeLaVaca, 9).
duracion(malPuntuado, 6).
duracion(laBellaYGraciosaMozaMarchoseALavarLaRopa, 8).
duracion(lutherapia, 15).
duracion(cantataDelAdelantadoDonRodrigoDiazDeCarreras, 17).
duracion(rhapsodyInBalls, 7).

% Necesitamos programar interprete/2, que relacione a una persona con un sketch en el que puede participar. 
% Inversible.

interprete(Artista, Sketch):-
    puedeCumplir(Artista,Rol),
    necesita(Sketch,Rol).

% Se precisa la relación duracionTotal/2, que relacione una lista de sketchs con la duración total que tomaría realizarlos todos. 
% Inversible para la duración.

duracionTotal(ListaSketchs, DuracionTotal):-
    findall(Duracion,(member(Sketch, ListaSketchs), duracion(Sketch, Duracion)),ListaDuracion),
    sum_list(ListaDuracion, DuracionTotal).

% Saber si un sketch puede ser interpretado por un conjunto de intérpretes. 
% Esto sucede cuando en ese conjunto disponemos de intérpretes que cubren todos los roles necesarios para el mencionado sketch.
% Inversible para el sketch.

puedeSerInterpretado(Sketch, Artistas):-
    necesita(Sketch, _),
    forall(necesita(Sketch,Rol),(member(Artista, Artistas), puedeCumplir(Artista, Rol))).
    

% Hacer generarShow/3 que relacione: 
% Un conjunto de posibles intérpretes.
% Una duración máxima del show.
% Una lista de sketches no vacía (un show), que deben poder ser interpretados por los intérpretes y durar menos que la duración máxima.
% Inversible para el show.

generarShow(_, []).
generarShow(Interpretes,  [Sketch | RestoShow]):-
    necesita(Sketch, _),
    puedeSerInterpretado(Sketch, Interpretes),
    generarShow(Interpretes, RestoShow).
    
% Los shows, muchas veces tienen algún participante estrella; que son aquellos que puede participar en todos los sketchs que componen dicho show. 
% Implementar un predicado que relacione a un show con un participante estrella.
% Inversible para la estrella
estrella(Show, Estrella):-
    puedeCumplir(Estrella,_),
    generarShow([Estrella], Show).


% Para hacer mejor el marketing, queremos saber si un show:
% Es puramenteMusical/1. Esto sucede cuando en todos los sketches, sólo se precisan roles de instrumentista.
% Tiene todosCortitos/1. Esto sucede cuando todos los sketches del show duran menos de 10 minutos.
% Los juntaATodos/1. Este evento especial solo pasa si la única manera de que el show suceda es que tengan que participar todos los intérpretes que conocemos.
% No necesitan ser inversibles

puramenteMusical(Show):-
    forall(member(Sketch, Show), necesita(Sketch, instrumentista(_))).

todosCortitos(Show):-
    forall(member(Sketch, Show), (duracion(Sketch, Duracion), Duracion < 10)).

/*juntaATodos(Show, ListaInterpretes):-
    findall(Interpretes, (member(Sketch, Show), puedeSerInterpretado(Sketch, Interpretes)), ListaInterpretes).*/
    

