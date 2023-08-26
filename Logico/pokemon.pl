% camino(GymA, GymB, DuracionViajeMin, CantidadPokeparadas).
camino(plaza_de_mayo, congreso, 9, 15).
camino(plaza_de_mayo, teatro_colon, 11, 15).
camino(plaza_de_mayo, abasto_shopping, 19, 28).
camino(plaza_de_mayo, cementerio_recoleta, 26, 36).
camino(congreso, teatro_colon, 10, 11).
camino(congreso, cementerio_recoleta, 15, 16).
camino(teatro_colon, abasto_shopping, 13, 20).
camino(teatro_colon, cementerio_recoleta, 17, 24).
camino(abasto_shopping, cementerio_recoleta, 27, 32).


/*
Nuestro primer objetivo es hacer mejorTour/2, que relacione un límite de minutos de duración y un tour detallado (siendo un tour, una lista de etapas) que nos diga de qué gimnasio a qué gimnasio debemos ir para poder pasar por todos, pero sólo una vez por cada uno, maximizando la cantidad de pokeparadas y dentro de nuestro límite de duración. Para esto, pensar en:
1- ¿Qué representa “una etapa” o elemento en el tour? Hay dos enfoques posibles principales:
    Cada etapa es un nuevo gimnasio.
    Cada etapa es un trayecto y se corresponde con un camino que conecta un gimnasio con otro.
    Recomendamos que sea alguno de estos, pero si piensan en otro modelo también puede ser válido. Consultar.
2- Tener en cuenta que, en un camino, no es necesario ir de un gimnasio A hacia otro B: bien se podría recorrer el trayecto en el sentido inverso, de B hacia A. Definir una abstracción que refleje lo anterior.
3- Generar una secuencia de etapas que pasa por todos los gimnasios, sin repetir los mismos y sin exceder el límite de tiempo.
    Tip: Puede ser más sencillo primero armar la secuencia y luego controlar el total, pero también puede hacerse todo junto.
4- Pueden ser útiles los predicados:
    permutation/2, el cual relaciona 2 listas cuando la segunda es una permutación de la primera. Este predicado es inversible para la segunda lista.
    list_to_set/2, que relaciona una lista con otra, si la segunda contiene los mismos elementos que la primera pero sin repeticiones de los mismos. Es inversible para la segunda lista y respeta el orden de aparición de los elementos (primera vez de c/u).
    En base a esas consideraciones, implementar mejorTour/2, que debe cumplirse para aquella secuencia de pasos que maximice la cantidad de paradas en su trayecto, siempre dentro del límite de tiempo establecido. No necesita ser inversible para el límite de tiempo.*/

mejorTour(Limite,Tour):- 
    secuenciaEnTiempo(Tour, Limite, Paradas), %Busca una secuencia de gimnasios
    not((secuenciaEnTiempo(_,Limite, Paradas2),Paradas2 > Paradas)). % compara la secuencia encontrada a ver si es la mejor, mirando si existe otra que sus pokeparadas sean mayores

caminoSinDireccion(GymA, GymB, Duracion, Cantidad):- %Como existen caminos de ida y vuelta, este predicado resuelve eso, diciendo que se revise tanto a ida como a vuelta
    camino(GymA, GymB, Duracion, Cantidad).
caminoSinDireccion(GymA, GymB, Duracion, Cantidad):-
    camino(GymB, GymA , Duracion, Cantidad).

gimnasio(Gym):- % Obtenemos solo el gimnasio buscado, con el distinct, ademas eliminamos duplicados.
    distinct(Gym, caminoSinDireccion(Gym,_,_,_)).

secuenciaEnTiempo(Gimnasios, TiempoTotal, PokeparadasEncontradas):-
    findall(Gym, gimnasio(Gym), ListaGym), % Busca una lista de gimnasios
    permutation(ListaGym, Gimnasios), % Busca las diferentes listas permutadas
    tour(Gimnasios, TiempoTrascurrido, PokeparadasEncontradas), % Busca de una lista de gimnasios 
    TiempoTrascurrido =< TiempoTotal.

tour([_],0,0).
tour([GymA,GymB|Gyms], TiempoTour, ParadasTour):- % Agarra una lista de gimnasios y va obteniendo del primer y segundo elemento, sus tiempos y pokeparadas
    caminoSinDireccion(GymA, GymB, Tiempo, Paradas), % Usa Camino sin direccion asi revisa tanto a izq como a derecha
    tour([GymB|Gyms],TiempoResto, ParadasResto), % Es recursiva para el resto de la lista
    TiempoTour is Tiempo + TiempoResto, 
    ParadasTour is Paradas + ParadasResto.

%-----------------------------------------------------------------------------------------------
/*
Ahora agregamos información: Un gimnasio está, en un determinado momento, ocupado por un equipo de un color (rojo, azul, amarillo). 
6- Agregar está información a la base de conocimiento para todos los gimnasios anteriores, sin modificar lo realizado hasta ahora. El shopping tendrá un color, el Congreso otro, y los demás un tercero.
7- Implementar estaSitiado/1. Un gimnasio está sitiado cuando todos sus vecinos están ocupados por equipos de un mismo color, que no es el mismo del equipo de ese gimnasio. Un gimnasio “vecino” es aquel conectado con un camino directamente, es decir, sin pasar por otros gimnasios en medio.

Validar el modelo con los tests dados a continuación. En el caso del tour, ajustar el formato de las etapas del mismo de acuerdo a la representación elegida por ustedes (en este caso, es de gimnasios, la opción A entre las planteadas).

*/

color(abasto_shopping, rojo). % Creamos cada gimnasio con el color indicado
color(congreso, azul).
color(cementerio_recoleta, amarillo).
color(plaza_de_mayo, amarillo).
color(teatro_colon, amarillo).

gimnasioVecino(Gimnasio, GimnasioVecino):- % Gimnasios relacionados entre si por un solo camino
    caminoSinDireccion(Gimnasio, GimnasioVecino,_,_).

estaSitiado(Gimnasio):-
    color(Gimnasio, Color), %Busco color de nuestro gimnasio
    gimnasioVecino(Gimnasio, GimnasioVecino), %Busco al gimnasio vecino
    color(GimnasioVecino, ColorVecino), %Color del gimnasio vecino
    Color \= ColorVecino, %Deben ser diferentes
    forall(gimnasioVecino(Gimnasio, Vecino2), color(Vecino2, ColorVecino)). % Para todos los otros gimnasios vecinos, su color es el color vecino encontrado anteriormente?

