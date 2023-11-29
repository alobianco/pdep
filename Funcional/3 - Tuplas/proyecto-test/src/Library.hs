module Library where
import PdePreludat


-------------Basicos-------------
--1.1 Si un numero es multiplo de 3--
esMultiploDeTres num = mod num 3 == 0

--1.2 Si un numero es multiplo de otro--
--esMultiploDe num1 num2 = mod num1 num2 == 0

--1.3 Cubo de un numero--
cubo = (^3)

--1.4 Area de un rectangulo--
area base altura = base * altura

--1.5 Cuando un año es bisiesto-- 
-- En una sola expresion. Comparaciones logicas --
--esBisiesto anio = esMultiploDe anio 400 || not(esMultiploDe anio 100) && esMultiploDe anio 4

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

-------------Aplicacion parcial-------------

--2.1 Siguiente--
siguiente :: Number -> Number
siguiente = (1+)

--2.2 Mitad--
mitad :: Number -> Number
mitad  = (/2)

--2.3 inversa--
inversa :: Number -> Number
inversa num = (/num)1 --Si es cero tkb

--2.4 doble y triple--

doble :: Number -> Number
doble  = (2*)
triple :: Number -> Number
triple  = (3*)

--2.5 Numero positivo--
esNumeroPositivo :: Number -> Bool
esNumeroPositivo num
    | num >= 0 = True
    | otherwise = False

-------------Composicion-------------

--2.6 Es multiplo de x--
esMultiploDe :: Number -> Number -> Bool
esMultiploDe x = (==0).(mod x)
--2.7 Año bisiesto--
esBisiesto :: Number -> Bool
esBisiesto anio = esMultiploDe anio 400 || not (esMultiploDe anio 100) && esMultiploDe anio 4

--2.8 Inversa Raiz Cuadrada--
inversaRaizCuadrada :: Number -> Number
inversaRaizCuadrada = inversa.sqrt

--2.9 Incremento a potencia--
incrementMCuadradoN n m = ((+m).(^2))n

--2.10 Resultado es par--
esResultadoPar :: Number -> Number -> Bool
esResultadoPar n m = (even.potencia n) m
potencia :: Number -> Number -> Number
potencia n m = n^m

--3.1 First3 Second3 Third3--
fst3 (a,_,_) = a
snd3 (_,b,_) = b
trd3 (_,_,c) = c

--3.2 Aplicar tupla de funcion a un dato--

aplicar (f1,f2) num =  (f1 num, f2 num)

--3.3 Cuenta bizarra--
cuentaBizarra :: (Number , Number) -> Number
cuentaBizarra (a,b)
    | fst (a,b) > snd (a,b) = a + b
    | snd (a,b) > (10 + fst (a,b)) = b - a
    | otherwise = a*b

--3.4 Notas alumno Solo con parciales--
--type Nota = (Number,Number)
esNotaBochazo :: Number -> Bool
esNotaBochazo = (<6)
aprobo :: NotasTotales -> Bool
aprobo notas = (not.esNotaBochazo.fst.notasFinales) notas && (not.esNotaBochazo.snd.notasFinales) notas 
esNotaPromocion :: NotasTotales -> Bool
esNotaPromocion notas= ((>=7).fst.parcial) notas && ((>=7).snd.parcial) notas
sumaNotas :: NotasTotales -> Number
sumaNotas notas = (fst.parcial) notas + (snd.parcial) notas
mayorQuince :: NotasTotales -> Bool
mayorQuince = (>=15).sumaNotas
promociono :: NotasTotales -> Bool
promociono notas = esNotaPromocion notas && mayorQuince notas

--3.5 Notas alumno con parciales y recuperatorios--

type NotasTotales = ((Number,Number),(Number,Number))
parcial (parciales, _) = parciales
recuperatorio (_,recuperatorios) = recuperatorios
notasFinales :: NotasTotales -> (Number, Number)
notasFinales ((p1,p2),(r1,r2)) = (max p1 r1, max p2 r2)

recuperoParciales notas = recuperatorio notas /= (-1,-1)
recuperoDeGusto notas = promociono notas && recuperoParciales notas



--3.6 mayor de edad--

type Persona = (String, Number)
edad :: Persona -> Number
edad (_,anio) = anio
esMayorDeEdad :: Persona -> Bool
esMayorDeEdad = (>=21).edad

--3.7 Calcular--

numeroPar n= (mod n 2) == 0

calcularPrimero (num1,_)
    | numeroPar num1 = doble num1
    | otherwise = num1

calcularSegundo (_,num2)
    | (not.numeroPar) num2 = siguiente num2
    | otherwise = num2

calcular dato = (calcularPrimero dato, calcularSegundo dato)