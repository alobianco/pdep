{-
Nombre: Lobianco, Agustin  
Legajo: 147139-9
Guia: Funcional 1: Primeros ejercicios
-}


--1.1 Si un numero es multiplo de 3--
esMultiploDeTres num = mod num 3 == 0

--1.2 Si un numero es multiplo de otro--
esMultiploDe num1 num2 = mod num1 num2 == 0

--1.3 Cubo de un numero--
cubo num = num ^ 3

--1.4 Area de un rectangulo--
area base altura = base * altura

--1.5 Cuando un año es bisiesto-- 
-- En una sola expresion. Comparaciones logicas --
esBisiesto anio = esMultiploDe anio 400 || not(esMultiploDe anio 100) && esMultiploDe anio 4

--- Con  Guardas ---
--esBisiesto anio
--    | esMultiploDe anio 400 = True
--    | esMultiploDe anio 100 = False
--    | esMultiploDe anio 4 = True
--    | otherwise = False

--1.6 Paso de Celsius a Fahrenheit--
celsiusToFahr temp = (1.8 * temp) + 32

--1.7 Paso de Fahrenheit a Celsius--
fahrToCelsius temp = (temp - 32) / 1.8

--1.8 Hace frio, temperatura indicada en fahrenheit--
haceFrio temp = (fahrToCelsius temp) < 8

--1.9 mcm--


gdc :: Int -> Int -> Int
gdc x y | x == y = x
        | x > y = gdc (x - y) y
        | x < y = gdc x (y - x)

