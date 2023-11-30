% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroina])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).


% 1 Dado el predicado controla/2
% Indicar, justificando, si es inversible y, en caso de no serlo
% dar ejemplos de las consultas que NO podrían hacerse y corregir la implementación para que se pueda.

% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).

%controla(Guardia, Otro):- prisionero(Otro,_), not(controla(Otro, Guardia)).
%No es inversible con el Guardia, porque no se liga previamente, se liga desde un not, que es un predicado de orden superior entonces no es inversible.

% Con inversibilidad
controla(Guardia, Otro):- prisionero(Otro, _), guardia(Guardia), not(controla(Otro, Guardia)).

% 2- conflictoDeIntereses/2: relaciona a dos personas distintas (ya sean guardias o prisioneros) 
% si no se controlan mutuamente y existe algún tercero al cual ambos controlan.
conflictoDeIntereses(Persona, OtraPersona):-
    controla(Persona, Tercero),
    controla(OtraPersona, Tercero),
    Persona \= OtraPersona,
    not(controla(Persona,OtraPersona)),
    not(controla(OtraPersona, Persona)).

%peligroso/1: Se cumple para un preso que sólo cometió crímenes graves.
%Un robo nunca es grave.
%Un homicidio siempre es grave.
%Un delito de narcotráfico es grave cuando incluye al menos 5 drogas a la vez, o incluye metanfetaminas.

peligroso(Prisionero):-
    prisionero(Prisionero,_),
    forall(prisionero(Prisionero, Crimen), crimenGrave(Crimen)).


crimenGrave(homicidio(_)).
crimenGrave(narcotrafico(Drogas)):- member(metanfetaminas, Drogas).
crimenGrave(narcotrafico(Drogas)):- length(Drogas, CantidadDrogas), CantidadDrogas >= 5.
    
% ladronDeGuanteBlanco/1: Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.

ladronDeGuanteBlanco(Prisionero):-
    prisionero(Prisionero,_),
    forall(prisionero(Prisionero, Crimen), esRoboMayor(Crimen)).

esRoboMayor(robo(Valor)):-
    Valor > 100000.
    

%condena/2: Relaciona a un prisionero con la cantidad de años de condena que debe cumplir. 
% Esto se calcula como la suma de los años que le aporte cada crimen cometido, que se obtienen de la siguiente forma:
% La cantidad de dinero robado dividido 10.000.
% 7 años por cada homicidio cometido, más 2 años extra si la víctima era un guardia.
% 2 años por cada droga que haya traficado.

condena(Prisionero, CondenaTotal):-
    prisionero(Prisionero,_),
    findall(Condena, (prisionero(Prisionero, Crimen), pena(Crimen, Condena)) , ListaAnios),
    sum_list(ListaAnios, CondenaTotal).

% Robo
pena(robo(DineroRobado), Pena):- Pena is DineroRobado / 10000.
% Homicidio
pena(homicidio(Victima), 7):- not(guardia(Victima)).
pena(homicidio(Victima), 9):- guardia(Victima).
% Narcotrafico
pena(narcotrafico(Drogas), Pena):- length(Drogas, CantidadDrogas), Pena is CantidadDrogas * 2.




% capoDiTutiLiCapi/1: Se dice que un preso es el capo de todos los capos cuando nadie lo controla, 
% pero todas las personas de la cárcel (guardias o prisioneros) son controlados por él, 
% o por alguien a quien él controla (directa o indirectamente).

persona(Persona):- prisionero(Persona,_).
persona(Persona):- guardia(Persona).

%Esto es una relacion transitiva
controlaDirectamenteOIndirectamente(Uno, Otro):- controla(Uno, Otro). % Controla Directamente
controlaDirectamenteOIndirectamente(Uno, Otro):- controla(Uno, Tercero), controlaDirectamenteOIndirectamente(Tercero, Otro). % Controla indirectamente

capo(Capo):-
    prisionero(Capo,_),
    not(controla(_,Capo)),
    forall((persona(Persona),Capo \= Persona), controlaDirectamenteOIndirectamente(Capo, Persona)).

    



    
    
