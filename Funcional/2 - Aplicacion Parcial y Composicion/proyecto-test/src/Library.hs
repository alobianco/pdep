module Library where
import PdePreludat

{-
Nombre: Lobianco, Agustin  
Legajo: 147139-9
Guia: Funcional 1: Primeros ejercicios
-}

-------------Aplicacion parcial-------------

--2.1 Siguiente--
siguiente :: Number -> Number
siguiente num = (1+)num

--2.2 Mitad--
mitad :: Number -> Number
mitad num = (/2)num

--2.3 inversa--
inversa :: Number -> Number
inversa num = (/num)1 --Si es cero tkb

--2.4 triple--
triple :: Number -> Number
triple num = (3*)num

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
esResultadoPar n m = even((n^m))
