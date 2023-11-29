% Relaciona Pirata con Tripulacion

tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).

tripulante(law, heart).
tripulante(bepo, heart).

tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).


% Relaciona Pirata, Evento y Monto
%% Sombrero de Paja
impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).
impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).
impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).
impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).
impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).
%% Heart
impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).
impactoEnRecompensa(bepo,sabaody,500).
%% Piratas de Arlong
impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

%% Punto 1 - Saber que tripulaciones participaron de un evento
participaronDelMismoEvento(Tripulacion1, Tripulacion2, Evento):-
    participoDeEvento(Tripulacion1, Evento),
    participoDeEvento(Tripulacion2, Evento),
    Tripulacion1 \= Tripulacion2.

participoDeEvento(Tripulacion, Evento):-
    tripulante(Pirata, Tripulacion),
    impactoEnRecompensa(Pirata, Evento,_).

%% Punto 2 - Pirata mas destacado en un evento
pirataMasDestacado(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, RecompensaMayor),
    forall(impactoEnRecompensa(_,Evento, RecompensaMenor), 
            RecompensaMayor >= RecompensaMenor).

%% Punto 3 - Pirata paso desapercibido
pasoDesapercibido(Pirata, Evento):-
    tripulante(Pirata, Tripulacion),
    participoDeEvento(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata, Evento,_)).

%% Punto 4 - Recompensa total de una tripulacion
recompensaTotal(Tripulacion, RecompensaTotal):-
    tripulante(_, Tripulacion),
    findall(RecompensaActual,
            (tripulante(Pirata, Tripulacion), recompensaDePirata(Pirata, RecompensaActual)), 
            ListaRecompensa),
    sum_list(ListaRecompensa, RecompensaTotal).

recompensaDePirata(Pirata, RecompensaTotal):-
    tripulante(Pirata,_),
    findall(Recompensa, impactoEnRecompensa(Pirata, _, Recompensa), ListaRecompensa),
    sum_list(ListaRecompensa, RecompensaTotal).

%% Punto 5 - Tripulacion temible
tripulacionEsTemible(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata, Tripulacion),peligroso(Pirata)).
tripulacionEsTemible(Tripulacion):-
    recompensaTotal(Tripulacion, RecompensaTotal),
    RecompensaTotal > 500000000.


peligroso(Pirata):-
    tripulante(Pirata,_),
    recompensaDePirata(Pirata, Recompensa),
    Recompensa > 100000000.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%      PARTE 2        %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Punto 6 - Frutas y peligroso
peligroso(Pirata):-
    comioFrutaPeligrosa(Pirata).

% comio(Pirata, fruta(Nombre, Tipo, peligrosa)).
comio(luffy, fruta(gomugomu, paramecia, noPeligrosa)).
comio(buggy, fruta(barabara, paramecia, noPeligrosa)).
comio(law, fruta(opeope, paramecia, peligrosa)).
comio(chopper, fruta(hitohito, zoan, humano)).
comio(lucci, fruta(nekoneko, zoan, leopardo)).
comio(smoker, fruta(mokumoku, logia, peligrosa)).

comioFrutaPeligrosa(Pirata):-
    comio(Pirata,fruta(_,paramecia,Peligrosa)),
    Peligrosa = peligrosa.

comioFrutaPeligrosa(Pirata):-
    comio(Pirata, fruta(_,zoan,Especie)),
    especieFeroz(Especie).

comioFrutaPeligrosa(Pirata):-
    comio(Pirata, fruta(_,logia,_)).

especieFeroz(lobo).
especieFeroz(leopardo).
especieFeroz(anaconda).

% Elegi un functor porque tenia que representar una fruta, pero con distintos tipos y datos, entonces un functor es lo mas facil para utilizar polimorfismo.

% Punto 7 - Piratas del asfalto
piratasDelAsfalto(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata, Tripulacion), puedeNadar(Pirata)).

puedeNadar(Pirata):-
    tripulante(Pirata, _),
    not(comio(Pirata,_)).



