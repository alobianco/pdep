module Library where
import PdePreludat

--- Listas + Orden Superior ---


--1.1 Suma lista de numeros--

-- se hace con sum [1,2,3] = 6
sumaLista = sum

--1.2 frecuencia cardiaca--
frecuenciaCardiaca = [80,100,120,128,130,123,125]

promedioFrecuenciaCardiaca :: [Number] -> Number
promedioFrecuenciaCardiaca frecuenciaCardiaca = (sumaLista frecuenciaCardiaca)/largoLista frecuenciaCardiaca

largoLista = length

frecuenciaCardiacaMinuto :: Number -> Number
frecuenciaCardiacaMinuto min = frecuenciaCardiaca !! indice
    where indice = (min `div` 10) - 1


