/*Cañerias - Primer Ejercicio*/

/*De los codos me interesa el color, p.ej. un codo rojo.*/
/*De los caños me interesan color y longitud, p.ej. un caño rojo de 3 metros.*/
/*De las canillas me interesan: tipo (de la pieza que se gira para abrir/cerrar), color y ancho (de la boca).*/


/*
Definir un predicado que relacione una cañería con su precio. Una cañería es una lista de piezas. Los precios son:
codos: $5.
caños: $3 el metro.
canillas: las triangulares $20, del resto $12 hasta 5 cm de ancho, $15 si son de más de 5 cm.
*/
/*Precios*/

/*codo (color).*/
precio(codo(_), 5).
/*canio (color, longitud).*/
precio(canio(_, Longitud), Precio):-
    Precio is Longitud * 3.
/*canilla (tipo, color, ancho).*/
precio(canilla(triangular, _, _), 20).
precio(canilla(Tipo, _, Ancho), 12):-
    Tipo \= triangular,
    Ancho =< 5.
precio(canilla(Tipo, _, Ancho), 15):-
    Tipo \= triangular,
    Ancho > 5.

/*
Definir el predicado puedoEnchufar/2, tal que puedoEnchufar(P1,P2) se verifique si puedo enchufar P1 a la izquierda de P2. Puedo enchufar dos piezas si son del mismo color, o si son de colores enchufables. 

Las piezas azules pueden enchufarse a la izquierda de las rojas
las rojas pueden enchufarse a la izquierda de las negras. 
Las azules no se pueden enchufar a la izquierda de las negras, tiene que haber una roja en el medio. 

P.ej.
sí puedo enchufar (codo rojo, caño negro de 3 m).
sí puedo enchufar (codo rojo, caño rojo de 3 m) (mismo color).
no puedo enchufar (caño negro de 3 m, codo rojo) (el rojo tiene que estar a la izquierda del negro).
no puedo enchufar (codo azul, caño negro de 3 m) (tiene que haber uno rojo en el medio).
*/

color(codo(Color), Color).
color(canio(Color,_),Color).
color(canilla(_,Color,_),Color).
color(extremo(_, Color),Color).

coloresEnchufables(rojo,negro).
coloresEnchufables(azul,rojo).
coloresEnchufables(Color,Color).

/*puedoEnchufar(Izq, Der).*/
puedoEnchufar(Pieza1, Pieza2):-
    color(Pieza1, Color1),
    color(Pieza2, Color2),
    Pieza1 \= extremo(derecho, _),
    Pieza2 \= extremo(izquierdo,_),
    coloresEnchufables(Color1,Color2).


/*
Modificar el predicado puedoEnchufar/2 de forma tal que pueda preguntar por elementos sueltos o por cañerías ya armadas. 
P.ej. una cañería (codo azul, canilla roja) la puedo enchufar a la izquierda de un codo rojo (o negro), y a la derecha de un caño azul. Ayuda: si tengo una cañería a la izquierda, ¿qué color tengo que mirar? Idem si tengo una cañería a la derecha.
*/

puedoEnchufar(Canieria, CanieriaOPieza):-
    last(Canieria, Pieza),
    puedoEnchufar(Pieza, CanieriaOPieza).

puedoEnchufar(CanieriaOPieza, [Pieza | _]):-
    puedoEnchufar(CanieriaOPieza, Pieza).

/*
Definir un predicado canieriaBienArmada/1, que nos indique si una cañería está bien armada o no. Una cañería está bien armada si a cada elemento lo puedo enchufar al inmediato siguiente, de acuerdo a lo indicado al definir el predicado puedoEnchufar/2.
*/

canieriaBienArmada([Pieza]):-
    color(Pieza,_).
canieriaBienArmada([Canieria]):-
    canieriaBienArmada(Canieria).
canieriaBienArmada([CanieriaOPieza | CanieriasOPiezas]):-
    puedoEnchufar(CanieriaOPieza, CanieriasOPiezas),
    canieriaBienArmada([CanieriaOPieza]),
    canieriaBienArmada(CanieriasOPiezas).


/*
Modificar el predicado puedoEnchufar/2 para tener en cuenta los extremos, que son piezas que se agregan a las posibilidades. De los extremos me interesa de qué punta son (izquierdo o derecho), y el color, p.ej. un extremo izquierdo rojo. Un extremo derecho no puede estar a la izquierda de nada, mientras que un extremo izquierdo no puede estar a la derecha de nada. Verificar que canieriaBienArmada/1 sigue funcionando.

Ayuda: resolverlo primero sin listas, y después agregar las listas. Lo de las listas sale en forma análoga a lo que ya hicieron, ¿en qué me tengo que fijar para una lista si la pongo a la izquierda o a la derecha?.  
*/



/*
Modificar el predicado canieriaBienArmada/1 para que acepte cañerías formadas por elementos y/u otras cañerías. P.ej. una cañería así: codo azul, [codo rojo, codo negro], codo negro  se considera bien armada.
*/



/*
Armar las cañerías legales posibles a partir de un conjunto de piezas (si tengo dos veces la misma pieza, la pongo dos veces, p.ej. [codo rojo, codo rojo] )
*/
