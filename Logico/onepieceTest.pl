:- include(onepiece).

:-begin_tests(participaronDelMismoEvento).
    test("Heart y Sombrero de Paja participaron de Dressrosa", nondet):-
        participaronDelMismoEvento(heart, sombreroDePaja, dressrosa).
    test("Solo los Piratas de Arlong participaron de Llegada a EastBlue", fail):-
        participaronDelMismoEvento(piratasDeArlong, _, llegadaAEastBlue).
:-end_tests(participaronDelMismoEvento).

:-begin_tests(pirataMasDestacado).
    test("Zoro fue el pirata mas destacado en el evento Dressrosa"):-
        pirataMasDestacado(zoro, dressrosa).
:-end_tests(pirataMasDestacado).

:-begin_tests(pasoDesapercibido).
    test("Bepo paso desapercibido en el evento DressRosa",nondet):-
        pasoDesapercibido(bepo, dressrosa).
    test("Bepo no paso desapercibido en el evento Sabaody", fail):-
        pasoDesapercibido(bepo, sabaody).
    test("Bepo no paso desaparcibido en el evento Enies Lobby, porque su tripulacion no participo", fail):-
        pasoDesapercibido(bepo, eniesLobby).
:-end_tests(pasoDesapercibido).

:-begin_tests(recompensaTotal).
    test("La tripulacion Sombrero de Paja tiene un botin acumulado de 1263000150",nondet):-
        recompensaTotal(sombreroDePaja, 1263000150).
:-end_tests(recompensaTotal).

:-begin_tests(tripulacionEsTemible).
    test("Sombrero de paja es una tripulacion temible",nondet):-
        tripulacionEsTemible(sombreroDePaja).
    test("Los piratas de Arlong no es una tripulacion temible",fail):-
        tripulacionEsTemible(piratasDeArlong).
:-end_tests(tripulacionEsTemible).


%:-begin_tests(Frutas).
%    test()