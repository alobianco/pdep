                            /*----------- Primera Clase -----------*/
/*Logico
    proposiciones logicas --> p(x) => q(x)
    x es el individuo y p y q son predicados, aquellas cosas que queremos saber su valor de verdad
    Un programa dentro del paradigma logico, consiste en formular predicados sobre los cuales hacer consultas por un "motor de inferencia"
    Si bien en la logica podemos indicar que cosas se cumplen, aca vamos a trabjar con conocimiento que sabemos que es verdadero
    Todo lo que no puede ser demostrado como verdadero, lo vamos a considerar falso.
    Definimos un universo de cosas verdaderas, solo este universo nos dira que es verdad en nuestro modelo, para saber si algo es falso, no lo incluimos en el universo
    Universo Cerrado
    Estructura -> Moton de inferencia y base de conocimientos (archivo.pl)
*/

/*Ejemplos de sintaxis de prolog*/
/*Clausulas - Su conjunto es un predicado - Tiene aridad 1 (cantidad de parametros que recibe)*/
humano(socrates). /*Importante el uso de minusculas y el punto final*/
humano(leo). /**/
humano(mati).

/*Predicado - Algo que da informacion. Te dice si algo es verdad o no*/

/*Predicado poliadico, aridad mayor a 2, establece una relacion*/
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(ned, rod).
padre(ned, todd).

/*definicion por extension y por comprension*/

/*Todo humano es mortal*/

mortal(Alguien):- humano(Alguien).

/*Consultas individuales y existenciales*/

/*
En la consulta de mortal(Alguien). 
Nos responden con Alguen = socrates si terminamos con un ; nos da el siguiente, si ponemos un . termina la instruccion
*/

/*Variable anonima -> mortal(_). si existe un resultado, no dice cual, solo si existe alguno*/

/*Consultas combinadas
padre(homero,_).    Homero es padre?
padre(ned,Quien).   De quien es padre Ned?

padre(Padre,Hijo).
Padre = Homero, Hijo = Bart;    Quien es el padre de quien?
Padre = Homero, Hijo = Lisa;
....etc.
    */

/*Disyuncion
    padre/2 es una disyuncion, porque se cumple para Homero y Bart o para Homero y Lisa o para Homero y Maggie

    Distintas clausulas forman distintas opciones para que el predicado sea verdadero y por lo tanto se comporta una disyuncion.
*/

/*Conjuncion
    La conjuncion logica tiene uqe darse dentro de una misma clausula y se representa mediante una coma
    Ej: abuelo(Abuelo, Nieto):-
        padre(Abuelo, Padre),
        padre(Padre, Nieto). 
*/
abuelo(Abuelo, Nieto):- padre(Abuelo, Padre),
                        padre(Padre, Nieto).
/*Cuando una variable toma un valor, el mismo no cambia hasta el fin de la clausula.
        Si en la consulta el Abuelo recibe un valor, el mismo queda ligado y no puede cambiarse: 
            el resto de la clausula debera verificarse conm esa variable teniendo ese valor
        Prolog tiene un mecanismo que hace que cada variable libre (no ligada) se asocie a todos los resultados posibles de la subconsulta
        para asi obtener todas las soluciones posibles. Este mecanismo se llama "backtracking".
*/
                            /*----------- Segunda Clase -----------*/
/*
     Relacion: Puede cumplirse para un individuo junto con multiples individuos distintos, no existe el "resultado" de una relacion, sino que la realcion se cumple o no
            Depende de como presentemos nuestas consultas y predicados, podemos intepretar los distintos individuos relacionados como "de entrada" o "de salida" para la relacion.
            Este concepto es la INVERSIBILIDAD
     Funcion: Cumple con unicidad, para ciertos valores de entrada, siempre hay un unico valor de salida
*/

/*Modelo un alumno*/

/*
        Cantidad de materias inscripto (numero entero)
        Promedio acumilado (numero con decimales)
        Dia que firma la materia (fecha)
        Nombre del alumno, puede ser string o una estructura compuesta por varios atomos (nombre y apellido, por ej)
        List de materias
*/

/*Individuos Simples*/
/*
        Con este predicado (hecho) come(mati,pasta). mati y pasta marcan lo que conocemos hasta el momento como un individuo, es un tipo de dato simple
        es atomico, no se puede descomponer en otros elementos mas chicos, lo puedo usar de distitnas formas:
        ?- come(mati,Que).
        Que = pasta.
    
    Numeros -> se utilizan como literales
                se pueden utilizar para operaciones aritmeticas y dfe comparacion por orden <,=<,>,>=.
    Suma -> sumar/3
                    sumar(Sumando1, Sumando2, Total):-
                        Total is Sumando1 + Sumando2.
    No se usa "=" se utiliza "is"
*/

/*Individuos Compuestos*/

/*Listas*/
/*
    Representan una serie de elementos ordenados que pueden repetirse
    [] representa la lista vacia
    [hola] lista con un solo elemento.
    [1,2,3,falopa] representa ua lista con 4 individuos exactamente, el primero de ellos es 1 y el ultimo es falopa, 
    Ademas vemos que pueden tener distintos tipos de elementos
    La lista es una estructura recursiva:
    Lista vacia[],
    O con elementos [Cabeza|Cola] - Cabeza y Cola son listas

    Funciones:
        length/2 -> relaciona una lista con su longitud: length([diego, franco, tom],3).
        member/2 -> relaciona un elemnto con la lista a la cual pertenece: member(agus,[agus, belen, mati]).
        append/3 -> relaciona dos listas con una tercera, que es la concatenacion de ellas en orden: append([1,2],[3,4,5],[1,2,3,4,5]).
        nth1/3 -> relaciona elemento, lista y posicion del elemento: nth1(belen,[agus, belen, mati],2).
        last/2 -> relaciona una lista con su ultime elemento: last([diego, franco, tom], tom).
        reverse/2 -> relaciona una lista con su inversa: reverse([1,2,3],[3,2,1]).
        sum_list/2 -> relaciona una lista de numeros con su suma: sum_list([1,2,3],6).
        list_to_set/2 -> relaciona una lista con otra con los mismos elementos pero sin repetir: list_to_set([1,1,1,2,2,1,1,2],[1,2]).
        max_member/2 y min_member/2 -> relaciona una lista con su mayor/menor elemento: max_member([1,5,9,3,7],9).
        subset/2 -> relaciona una lista con otra, si la segunda es un subconjunto de la primera: subset([agus, belen, mati],[agus, belen]).      
*/
/*Functores*/
/*
    Son individuos con estructuras de datos de cantidad de elementos fija, como tuplas o data de haskell
    tienen un nombre y cantidad de elementos que los componen
    la sintaxis es igual a la de un predicado, pero la diferencia con estos es que no tienen un valor de verdad, de la misma forma que 4, juan, carretilla o cualquier otro individuo no lo tiene por si mismo: pueden cumplir o no un predicado, pero no se cumplen o no por si mismos
    Ejemplo: nacio(mati, fecha(3,8,1981)).
    Tenemos el predicado nacio/2 y el functor fecha(3,8,1981) que lo cumple junto con mati.
    La fecha no es verdadera ni falsa, sino que el predicado nacio/2 se cumple para esos individuos (y en ese orden)
    ¿Como consulto un predicado que maneja functores?
    De la misma forma que cualquier otro: ?- nacio(Quien, Cuando). - Quien = mati, Cuando = fecha(3,8,1981).
*/
/*Pattern Matching*/
/*
    En logico todo se hace por Pattern Matching. En algun punto, tarde o temprano todo se resuelve por pattern matching
    Es la coincidencia entre argumentos en una consulta y los parametros definidos para el predicado
    Si un argumento coincide con un parametro definido en un hecho, la consulta es verdadera y si es con una regla, se continua con el proceso con las subconsultas
    esto se repite hasta que, en algun punto, llegamos a una clausula que matchea y es verdadera o el predicado no cubre el caso y es falsa

    Con individuos compuestos
    Los individuos compuestos me permiten explotar mas el pattern matching, por ejemplo, si quiero consultar quien nadio en 1981, puedo hacerlo asi.
    ?- nacio(Quien, fecha(_,_,1981)).
    Quien = mati.
    O bien obtener en que mes nacio mati: ?- nacio(mati, fecha(_,Mes,_)).
    Mes = 8.
    O tambien que dia y mes de 1981 hubo nacimientos: ?- nacio(_,fecha(Dia,Mes,1981)).
    Dia = 3, Mes = 8.


    NO PUEDO usar el nombre del functor como variable. Esto NO ES VALIDO: ?- nacio (mati, Tipo(_,_,_)).

    Con listas tambien puedo hacer pattern matching, por ejemplo para obtener la cabeza de una lista puedo definir:
    cabeza([Cabeza|_], Cabeza).
    Y consultarla: ?- cabeza([1,2,3], Cabeza).
    Cabeza = 1.

    Y si no hay un patron definicod para mi consulta, que pasa?
    ?- cabeza([], Cabeza).
    false.
*/
                            /*----------- Tercera Clase -----------*/
/*
    Recursividad: Definir algo recursivo significa que en algun lugar de la definicion aparece ese mismo termino que estamos definiendo.
    Una lista es una estructura recursiva porque la cola de una lista (cuando existe) es una lista en si misma
    Un predicado puede estar definido en forma recursiva cuando como antecedente de alguna de sus clausulas se usa el mismo predicado
    Ej:
        1) factorial (0,1).  -- NUMERICO
            factorial(Numero, Factorial):-
                Anterior is Numero - 1,
                factorial(Anterior, FactorialAnterior),  -- Parte recursiva
                Factorial is Numero * FactorialAnterior.
        2) ancestro(Ancestro, Sucesor):- -- NO NUMERICO
            padre(Ancestro, Sucesor).
           ancestro(Ancestro, Sucesor):-
            padre(Ancestro, Alguien),
            ancestro(Alguien,Sucesor). -- Parte Recursiva
    
    Caso base, saber donde cortar la recursividad.
            En una lista, es el caso base de la lista vacia, dentro de la cual no hay otra lista vacia
            En un predicado, el caso base es una clausula que NO use como subconsulta al propio predicado, que se esta definiendo.
                Es bastatnte comun que sea un hecho, pero perfectamente puede ser una regla, siempre que no incluya una subclausula recursiva.
    Caso recursivo.
            Hay que considerar que la clausula recursiva, para que tenga sentido, tienen que presetanr algun cambio, asi sea minimo. Si simplemente hacemos esto, entramos en una recursividad infinita:
                regla (X,Y):- regla(X,Y). o bien regla (X,Y):- regla(Y,X). (Nunca van a terminar, recursivas para siempre).
    
        length([],0). -- Caso base
        length([_|Cola], N):- length(Cola,NCola), N is NCola + 1. -- Caso recursivo.

    Cambio en factorial => Si buscamos el factorial de -1, va a ir a los negativos, entonces agregamos.
            factorial (0,1).  -- Base
            factorial(Numero, Factorial):-
                Numero > 0, -- Nuevo
                Anterior is Numero - 1,
                factorial(Anterior, FactorialAnterior),  -- Parte recursiva
                Factorial is Numero * FactorialAnterior.

    Otros ejemplos
    nth1/3:
    enesimo(X,[X|_],1).
    enesimo(X,[_,Cola], Posicion):-
        enesimo(X,Cola, PosicionCola),
        Posicion is PosicionCola + 1.
*/
                            /*----------- Cuarta Clase -----------*/
/*
 Orden superior
 Acciones: Tenemos a ciertas personas que realizaron acciones, buenas, malas y travesuras.
  realizo(Persona, Tipo de Accion).
*/
realizo(fede, buena).
realizo(topy, travesura).
realizo(agustin, mala).
realizo(topy, buena).
/*Predicado orden superior -> NOT*/
buenaPersona(Persona):-
    not(realizo(Persona, mala)).
/*NOT, tiene problemas de inversibilidad*/
%Usamos un predicado generador
buenaPersona(Persona):-
    realizo(Persona,_), %predicado generador
    not(realizo(Persona,mala)).

/*
Nos permite generar valores existentes y validos para una variable, podria implementarse de distitnas maneras
    - Utilizar un predicado existente
    - Escribir un predicado para generar a partir de otro: persona(Persona):- realizo(Persona, _).
    - Definir uno nuevo por extension:
        persona(fede).
        persona(agustin).
        persona(topy).
*/

/* Acciones2: Saber si una persona es buena, que es cuando todas aquellas acciones que realizo fueron buenas.*/
%realizo(Persona, Accion).
realizo(fede, ayudo(mati)).
realizo(topy, desaparecioGuita).
realizo(topy, ayudo(franco)).
realizo(agustin, prometioAsado).

%accionTipo(Accion, Tipo).
accionTipo(ayudo(_),buena).
accionTipo(prometioAsado,mala).
accionTipo(desaparecioGuita,travesura).

/*Predicado Orden Superior -> FORALL*/
buenaPersona(Persona):-
    forall(realizo(Persona,Accion), accionTipo(Accion, buena)).

%Mismo problema de inversibilidad
buenaPersona(Persona):-
    realizo(Persona,_),
    forall(realizo(Persona,Accion), accionTipo(Accion, buena)).

%Cantidad de acciones: Cuantas acciones realizo una persona
cantidadDeAcciones(Persona, Cantidad):-
    findall(Accion, realizo(Persona,Accion),Acciones),
    length(Acciones,Cantidad).
%Mismo problema de inversibilidad, tenemos que ligar persona
cantidadDeAcciones(Persona, Cantidad):-
    realizo(Persona,_),
    findall(Accion, realizo(Persona,Accion),Acciones),
    length(Acciones,Cantidad).
/*Analisis de inversibilidad general
    Variables que no deben tomar multiples valores dentro del predicado de orden superior y aparecen en un solo elemento de la relacion
    Persona siempre aparece una vez por predicado

    Variables que deben tomar multiples valores y por lo tanto NO deben estar ligadas
    por ejemplo accion, que aparece multiples veces
*/

                            /*----------- Quinta Clase -----------*/
/*
%Elementos de Diseño
    Diseñar es: Definir los componentes, la responsabilidad de cada uno y como se relacionan entre ellos.

Acoplamiento-> Grado de conocimiento que existe entre nuestros componentes

Code Smells-> Malas practivas comunes, que señalan la posibilidad de mejorar nuestra solucion, incluso cuando ya "anda".

Supongo un problema.
Existen plataformas donde hay series y lo modelamos de la siguiente manera:
*/

%produce(Plataforma, serie(Titulo,Temporadas)).
produce(netflix, serie(theWalkingDead,10)).
produce(netflix, serie(mindhunter,2)).
produce(netflix, serie(umbrellaAcademy,2)).
produce(netflix, pelicula(awake, 2021)).

%negacion vs asercion
%asercion Vx:p(x) -> q(x)
divertida(Plataforma):-
    produce(Plataforma,_),
    forall(produce(Plataforma, serie(_,Temporadas)), Temporadas > 4).
%negacion ∄x: p(x) ^ ¬(q(x))
divertida(Plataforma):-
    produce(Plataforma,_),
    not((produce(Plataforma, serie(_,Temporadas)), not(Temporadas > 4))).
%Mas complicada de entender, nos quedamos con la asercion


%Duplicidades
%Conocer la cantidad de contenidos de una productora
cantidadTitulos(Productoras, Cantidad):-
    produce(Productora,_),
    findall(Peli, produce(Productora, pelicula(Peli,_,_)), Peliculas),
    findall(Serie, produce(Productora, serie(Serie, _)), Series).

%Cambio para eliminar duplicidades
cantidadTitulos(Productora,Cantidad):-
    produce(Productora,_),
    findall(Contenido, produce(Productora, Contenido), Contenidos),
    length(Contenidos, Cantidad).

%Otro caso, Si quiero los titulos

titulo(Titulo, serie(Titulo,_)).
titulo(Titulo, pelicula(Titulo,_)).

cantidadTitulo(Productora,Cantidad):-
    produce(Productora,_),
    findall(Titulo, (produce(Productora,Contenido), titulo(Titulo,Contenido)), Titulos),
    length(Titulos, Cantidad).

%Contar para >0 o chequear existencia
%Una productora es interesante si, tiene un menos una pelicula producida en 2021
interesante(Productora):-
    produce(Productora, pelicula(_,2021)).
%Solo piden por un valor de verdad, no por todas entonces seria incorrecto buscar con un findall, solo es necesario una pelicula para cumplir

/*
Lazy predicate
    Algo que podemos encontrar en cualquier paradigma es Lazy <Component>, nos referimos asi cuando no aporta nada a la situacion
*/
%Por ejemplo:
interesante(Productora):-
    tienePeliculaInteresante(Productora).

tienePeliculaInteresante(Productora):-
    produce(Productora, pelicula(_,2021)).

/*
La NO incognita
    Las peliculas tienen un puntaje y se calcula como:
    9 si es de 2021
    Sino es de 2021, la decima parte del largo de su nombre
*/
puntaje(pelicula(_,2021),9).
puntaje(pelicula(Nombre, Anio),Puntaje):-
    Anio \= 2021,
    atom_length(Nombre, Cantidad),
    Puntaje is Cantidad/10.

/*
Explosion Conbinatoria -- Aprovechamos la inversibilidad
    Usando las herramientas que ya vimos, podemos necesitar modelar conjuntos alternativos de opciones
    Vamos a ver con un ejemplo: Como puedo dar el vuelto de un determinado importe pagado con un billete/moneda de una denominacion dada (asumiendo valores enteros)?
        Si tengo que pagar $99 y pago con $100, el vuelto es $1 y solo puedo dar una moneda de $1.
        Si tengo que pagar $98, en cambio, pagando con $100, el vuelto es $2 y lo puedo obtener con 2 monedas de $1 o con 1 moneda de $2, Ambas son opciones validas.
    Cada opcion es un conjunto de denominaciones que podemos usar para "armar" el vuelto
*/

%Base de conocimiento
denominacion(1000).
denominacion(500).
denominacion(200).
denominacion(100).
denominacion(50).
denominacion(20).
denominacion(10).
denominacion(5).
denominacion(2).
denominacion(1).

/*Armamos nuestro conjunto de acuerdo al importe a pagar y el monto inicial*/
vuelto(Importe, Pago, Vuelto):-
    TotalVuelto is Pago - Importe,
    denominaciones(TotalVuelto, Vuelto).

%Si no hay mas que pagar, no necesito
denominaciones(0,[]).

%Si queda algo que pagar, tomo un billete/moneda, lo descuenta y sigo el proceso
denominaciones(Total, [Denominacion|Denominaciones]):-
    Total > 0,
    denominacion(Denominacion),
    %between(1, Total, Denominacion), Nos dice que la denominacion debe estar entre 1 y Total, sino no entra, no es necesario porque para 0 entra en la primera clausura y para menores, directamente no ingresa.
    Resto is Total - Denominacion,
    denominaciones(Resto, Denominaciones).

/*Optimizamos, No queremos cualquier denominacion en cada punto, sino la mayor posible
No me interesa la opcion de dar 98 monedas de $1 como vuelto de un importe de $2 cuando me pagan con $100*/
denominaciones(Total, [Denominacion|Denominaciones]):-
    Total > 0,
    denominacion(Denominacion),
    between(1, Total, Denominacion),
    not((denominacion(Otra), between(Denominacion, Total, Otra))), %No puede haber otra denominacion que este entre la actual y el total.
    Resto is Total - Denominacion,
    denominaciones(Resto, Denominaciones).

%Sin repetir.
/*
El ejemplo anterior permitia que cada deniminacion se repitiera N veces.
En algunos casos, podemos tener los individuos a considerar limitados de alguna forma. ¿Como hacemos para armar la combinacion de soluciones con esa limitacion?
    Si tenemos un conjunto de individuos candidatos, podemos ir "descartando" los que ya usamos.
    Ese conjunto podemos conocerlo de antemano, o bien podemos armarlo nosotros en cbase a otra consulta usando findall/3
    Una vez que tenemos el conjunto de cantidadtos, la combinacion va a ser un subconjunto del mismo.

Un grupo comando quiere infiltrarse en la base enemiga, La comandante del escuadron de 5 personma para esta infiltracion: fede, belen, tom, franco, diego.
    ¿Que opciones tiene para armar el grupo que va a infiltrarse?
    A cada comando, puedo decidir si incluirlo o bien descartarlo:
*/
%Opcion uno - Utilizo la persona
escuadronPosible(Candidatos, [Persona|RestoSeleccion]):-
    select(Persona, Candidatos, RestoCandidatos),
    escuadronPosible(RestoCandidatos, RestoSeleccion).
%Opcion dos - No utilizo la persona
escuadronPosible(Candidatos, RestoSeleccion):-
    select(_, Candidatos, RestoCandidatos),
    escuadronPosible(RestoCandidatos, RestoSeleccion).
escuadronPosible(_,[]).

/*
El grupo tiene que estar formado por los integrantes candidatos del escuadron.
Ademas, el escuadron no puede estar vacio
*/
escuadronSeleccionado(Seleccion):-
    candidatos(Candidatos),
    escuadronPosible(Candidatos, Seleccion),
    Seleccion \= [].
    
candidatos([fede,belen,tom,franco,diego]).
%candidatos(Candidatos):-
%    findall(Comando, integrante(Comando),Candidatos).

/*
--ORDEN SUPERIOR SEGUNDA PARTE-- 
Ejemplo - Dobles
    Como hariamos para obtener los dobles de una lista de numeros, que queremos relacionar?
*/
doble(Numero, Doble):-
    Doble is Numero * 2.

dobles(Lista, Dobles):-
    findall(Doble, member(N,Lista), doble(N, Doble),Dobles).
%esta version es mas algoritmica

%Map en logico

/*
Necesitamos
    Lista de numeros
    Lista de Dobles
    El predicado que permite relacionar un numero con su doble
*/


%% maplist/3

doble(Numero, Doble):-
    Doble is Numero * 2.
dobles(Lista, Dobles):-
    maplist(doble, Lista, Dobles).

/*
maplist/3

maplist(Predicado, Lista, ListaResultante).

Predicado debe ser un predicado de aridad > 1
Lista es la lista de elementos que van a ser parte de la relacion del predicado
ListaResultante lista de elementos "resultantes" de cada una de las relaciones

La inversibilidad del maplist esta relacionada a la inversibilidad de los predicados que usemos

maplist(plus(2), ListaOriginal, [2,4]).
ListaOriginal = [0,2].
--Es inversible--

maplist(sum_list, ListaOriginal,[3,4]).
<error>
--No es inversible-- hay muchas listas
*/

/*
Generamos nuestros propios predicados de orden superior

Se realiza utilizando el predicado call/1 o mejor call/N, siempre y cuando N>0


call(10 is 2*5).
true

call(length([],1)).
false.

call(sum_list,[1,2,3],Total).
Total = 6.

call(sum_list([3,2,1]),Total).
Total = 6.
*/

