module Library where
import PdePreludat

{-
Nombre: Lobianco, Agustin  
Legajo: 147139-9
Guia: Funcional 1: Primeros ejercicios
-}

-------------Basicos-------------
--1.1 Si un numero es multiplo de 3--
esMultiploDeTres num = mod num 3 == 0

--1.2 Si un numero es multiplo de otro--
esMultiploDe num1 num2 = mod num1 num2 == 0

--1.3 Cubo de un numero--
cubo num = num ^3

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
haceFrio temp = fahrToCelsius temp < 8

--1.9 mcm--

mcm num1 num2 = (num1*num2)/(gcd num1 num2)

--1.10 Dispersion--

--1.10.a--

dispersion mediciona medicionb medicionc = max3 mediciona medicionb medicionc - min3 mediciona medicionb medicionc

max3 num1 num2 num3= max (max num1 num2) num3

min3 num1 num2 num3= min (min num1 num2) num3

--1.10.b--
diasParejos a b c= (dispersion a b c) < 30

diasLocos a b c = (dispersion a b c) > 30

diasNormales a b c=  (diasLocos a b c) && (diasParejos a b c)

--1.11 Plantacion--

pesoPino altura 
    | altura >=3 = 3 * altura
    | otherwise = 2 * altura

esPesoUtil peso 
    | peso >= 400 && peso <= 1000 = True
    | otherwise = False

sirvePino = (esPesoUtil.pesoPino)

--1.12 cuadrados perfectos--
cuadradoPerfecto n = revisoCuadrado n 1

revisoCuadrado x i
    | i * i == x = True
    | i * i > x = False
    | otherwise = revisoCuadrado x (i + 1)