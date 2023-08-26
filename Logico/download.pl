/*
contenido/4, que relaciona: una empresa, nombre del servidor, peso en GBs del contenido y el contenido propiamente dicho, que puede ser libro, disco de música, serie o película:
*/

% libro(título, autor, edición)
recurso(amazingzone, host1, 0.1, libro(lordOfTheRings, jrrTolkien, 4)).
recurso(g00gle, ggle1, 0.04, libro(fundation, asimov, 3)).
recurso(g00gle, ggle1, 0.015, libro(estudioEnEscarlata, conanDoyle, 3)).

% musica(título, género, banda/artista)
recurso(spotify, spot1, 0.3, musica(theLastHero, hardRock, alterBridge)).
recurso(pandora, pand1, 0.3, musica(burn, hardRock, deepPurple)).
recurso(spotify, spot1, 0.3, musica(2, hardRock, blackCountryCommunion)).
recurso(spotify, spot2, 0.233, musica(squareUp, kpop, blackPink)).
recurso(pandora, pand1, 0.21, musica(exAct, kpop, exo)).
recurso(pandora, pand1, 0.28, musica(powerslave, heavyMetal, ironMaiden)).
recurso(spotify, spot4, 0.18, musica(whiteWind, kpop, mamamoo)).
recurso(spotify, spot2, 0.203, musica(shatterMe, dubstep, lindseyStirling)).
recurso(spotify, spot4, 0.22, musica(redMoon, kpop, mamamoo)).
recurso(g00gle, ggle1, 0.31, musica(braveNewWorld, heavyMetal, ironMaiden)).
recurso(pandora, pand1, 0.212, musica(loveYourself, kpop, bts)).
recurso(spotify, spot2, 0.1999, musica(aloneInTheCity, kpop, dreamcatcher)).

% serie(título, géneros)
recurso(netflix, netf1, 30, serie(strangerThings, [thriller, fantasia])).
recurso(fox, fox2, 500, serie(xfiles, [scifi])).
recurso(netflix, netf2, 50, serie(dark, [thriller, drama])).
recurso(fox, fox3, 127, serie(theMentalist, [drama, misterio])).
recurso(amazon, amz1, 12, serie(goodOmens, [comedia,scifi])).
recurso(netflix, netf1, 810, serie(doctorWho, [scifi, drama])).

% pelicula(título, género, año)
recurso(netflix, netf1, 2, pelicula(veronica, terror, 2017)).
recurso(netflix, netf1, 3, pelicula(infinityWar, accion, 2018)).
recurso(netflix, netf1, 3, pelicula(spidermanFarFromHome, accion, 2019)).


%descarga/2
descarga(mati1009, strangerThings).
descarga(mati1009, infinityWar).
descarga(leoOoOok, dark).
descarga(leoOoOok, powerslave).


/*
Para esto se pide realizar los siguientes predicados, teniendo en cuenta que todos deben ser totalmente inversibles, a menos que se aclare lo contrario.
*/
/*
1- La vida es más fácil cuando hablamos solo de los títulos de las cosas...
    titulo/2. Relacionar un contenido con su título.
    descargaContenido/2. Relaciona a un usuario con un contenido descargado, es decir toda la información completa del mismo.
*/

recurso(Contenido):-recurso(_,_,_,Contenido). % Generador, agarra un predicado mas complejo y lo devuelve mas corto, solo con lo que nos interesa

titulo(Contenido, Titulo):- % Utilizando el predicado anterior, podemos conseguir facilmente el titulo de cada contenido
    recurso(Contenido),
    tituloContenido(Contenido, Titulo).

tituloContenido(libro(T,_,_),T).
tituloContenido(musica(T,_,_),T).
tituloContenido(serie(T,_),T).
tituloContenido(pelicula(T,_,_),T).

descargaContenido(Usuario,ContenidoDescargado):-
    descarga(Usuario,Titulo),
    titulo(ContenidoDescargado, Titulo).

/*
2- contenidoPopular/1. Un contenido es popular si lo descargan más de 10 usuarios.
*/

contenidoPopular(Contenido):-
    recurso(Contenido),
    findall(Usuario, descargaContenido(Usuario, Contenido), ListaUsuario),
    length(ListaUsuario, Cantidad),
    Cantidad > 10.
    

/*
3- cinefilo/1  Un usuario es cinéfilo si solo descarga contenido audiovisual (series y películas)
*/

usuario(Usuario):-
    distinct(Usuario, descarga(Usuario,_)).  %Agarra una parte del otro predicado y no lo repite, muy bueno.


contenidoAudiovisual(serie(_,_)).
contenidoAudiovisual(pelicula(_,_,_)).

cinefilo(Usuario):-
    usuario(Usuario),
    forall((Usuario, Contenido), contenidoAudiovisual(Contenido)).

/*
4- totalDescargado/2. Relaciona a un usuario con el total del peso del contenido de sus descargas, en GB
*/

pesoDescarga(Usuario, Contenido, Peso):-
    descargaContenido(Usuario, Contenido),
    recurso(_,_,Peso,Contenido).

totalDescargado(Usuario,TotalPeso):-
    usuario(Usuario),
    findall(Peso, pesoDescarga(Usuario,_, Peso), ListaPeso),
    sumlist(ListaPeso, TotalPeso).
    
/*
5- usuarioCool/1. Un usuario es cool, si solo descarga contenido cool:
    La música es cool si el género es kpop o hardRock.
    Las series, si tienen más de un género.
    Las películas anteriores al 2010 son cool.
    Ningún libro es cool.
*/

usuarioCool(Usuario):-
    usuario(Usuario),
    forall(descargaContenido(Usuario, Contenido), esCool(Contenido)).

esCool(musica(_,kpop,_)).
esCool(musica(_,hardRock,_)).
esCool(serie(_,Genero)):-
    length(Genero, Largo),
    Largo > 1.
esCool(pelicula(_,_,Anio)):-
    Anio < 2010.

/*
6- empresaHeterogenea/1. Si todo su contenido no es del mismo tipo. Es decir, todo película, o todo serie... etc.
*/
empresaHeterogenea(Empresa):-
    recurso(Empresa, _, _, Contenido1),
    recurso(Empresa, _, _, Contenido2),
    tipoContenido(Contenido1, Tipo1),
    tipoContenido(Contenido2, Tipo2),
    Tipo1 \= Tipo2.

%tipoContenido(libro(_,_,_), libro).
tipoContenido(Contenido, Tipo):-
    Contenido =.. [Tipo|_]. % =.. es un operador que agarra tu functor y lo convierte en una lista, por eso se toma el Tipo, para saber que Tipo es ese dato, es muy falopa esto



/*
7- Existe la sobrecarga de equipos, por lo tanto vamos a querer trabajar sobre los servidores a partir  del peso de su contenido:
    cargaServidor/3. Relaciona a una empresa con un servidor de dicha empresa y su carga, es decir el peso conjunto de todo su contenido.
    tieneMuchaCarga/2. Relaciona una empresa con su servidor que tiene exceso de carga. Esto pasa cuando supera los 1000 GB de información.
    servidorMasLiviano/2. Relaciona a la empresa con su servidor más liviano, que es aquel que tiene menor carga, teniendo en cuenta que no puede tener mucha carga.        
    balancearServidor/3. Relaciona una empresa, un servidor que tiene mucha carga y el servidor más liviano de la empresa; de forma tal de planificar una migración de contenido del primero al segundo, los cuales deben ser distintos.
*/

empresaServidor(Empresa, Servidor):-
    distinct(Servidor, recurso(Empresa, Servidor, _ ,_)).

cargaServidor(Empresa, Servidor, Carga):-
    empresaServidor(Empresa, Servidor),
    findall(Peso, recurso(Empresa, Servidor, Peso,_),ListaPeso),
    sumlist(ListaPeso, Carga).


tieneMuchaCarga(Empresa, Servidor):-
    cargaServidor(Empresa, Servidor, Carga),
    Carga > 1000.

servidorMasLiviano(Empresa, Servidor):-
    cargaServidor(Empresa, Servidor, Carga),
    not(tieneMuchaCarga(Empresa, Servidor)), % No puede ser uno que tenga mucha carga
    not((cargaServidor(Empresa, _, OtraCarga), OtraCarga < Carga)). % No puede existir otro que tenga mas carga que el que queremos (LA DIFERENCIA CON EL ANTERIOR ES QUE NO NOS INTERESA EL SERVIDOR ACA PORQUE LO TIENE QUE TRAER DE ANTES)

balancearServidor(Empresa, ServidorCargado, ServidorLiviano):-
    tieneMuchaCarga(Empresa, ServidorCargado),
    servidorMasLiviano(Empresa,ServidorLiviano).