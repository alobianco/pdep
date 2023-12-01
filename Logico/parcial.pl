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

rolesSketch(Sketch, Roles):-
    necesita(Sketch,_),
    findall(Rol, necesita(Sketch, Rol), Roles).

satisfaceUnRol(Artista, Sketch):-
    puedeCumplir(Artista,_),
    necesita(Sketch,_),
    rolesSketch(Sketch, Roles),
    forall(member(Rol, Roles), puedeCumplir(Artista, Rol)).
    





















/*puedeRealizarConjunto([],_).
puedeRealizarConjunto([Interprete | Resto], Sketch):-
    puedeCumplir(Interprete, Rol),
    necesita(Sketch, Rol),
    puedeRealizarConjunto(Resto, Sketch).


puedeSerInterpretado(Sketch, Interpretes):-
    necesita(Sketch,_),
    puedeRealizarConjunto(Interpretes, Sketch).*/


% [daniel, carlos] --> 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % payadaDeLaVaca Daniel, Jorge
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % malPuntuado Daniel, Marcos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % laBellaYGraciosaMozaMarchoseALavarLaRopa, actor(canto)). % Daniel, Carlos, Carlitos, Marcos, Jorge
    % laBellaYGraciosaMozaMarchoseALavarLaRopa, instrumentista(violin)). % Carlos
    % laBellaYGraciosaMozaMarchoseALavarLaRopa, instrumentista(tuba)). % Daniel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % lutherapia, actor(paciente) % Daniel
    % lutherapia, actor(psicologo) % Marcos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % cantataDelAdelantadoDonRodrigoDiazDeCarreras, actor(narrador) % Daniel, Marcos
    % cantataDelAdelantadoDonRodrigoDiazDeCarreras, instrumentista(percusion) % Daniel, Marcos
    % cantataDelAdelantadoDonRodrigoDiazDeCarreras, actor(canto) % Daniel, Carlos, Carlitos, Marcos, Jorge
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % rhapsodyInBalls, instrumentista(bolarmonio) % Jorge
    % rhapsodyInBalls, instrumentista(piano) % Carlitos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%