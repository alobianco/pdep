module Library where
import PdePreludat

data Pizza = Pizza {
    ingredientes :: [String],
    tamanio :: Number,
    cantCalorias :: Number
} deriving Show

grandeDeMuzza = Pizza{
    ingredientes = ["salsa", "mozzarella", "orégano"],
    tamanio = 8,
    cantCalorias = 350
}

individualDePalmito = Pizza{
    ingredientes = ["salsa", "palmito", "amor"],
    tamanio = 4,
    cantCalorias = 250
}

giganteEspecial = Pizza{
    ingredientes = ["salsa", "mozzarella", "oregano","jamon","morrones","aceitunas"],
    tamanio = 10,
    cantCalorias = 1000
}

chicaDeHuevo = Pizza{
    ingredientes = ["salsa", "mozzarella", "huevo"],
    tamanio = 6,
    cantCalorias = 300
}

nivelDeSatisfaccion :: Pizza -> Number
nivelDeSatisfaccion (Pizza ingre _ calorias)
    | elem "palmito" ingre = 0
    | calorias > 500 = calculoSatisfaccion ingre
    | otherwise = ((calculoSatisfaccion ingre) / 2)

calculoSatisfaccion :: [String] -> Number
calculoSatisfaccion ingre = ((80*).length) ingre

valorDePizza  (Pizza ingre tam _) =
    120 * length ingre * tam

nuevoIngrediente ::  String -> Pizza -> Pizza 
nuevoIngrediente ingrediente pizza  
    | elem ingrediente $ ingredientes pizza = pizza
    | otherwise = pizza{
        ingredientes = ingrediente : ingredientes pizza,
        cantCalorias = cantCalorias pizza + 2 * length ingrediente
    }

agrandar pizza = pizza { tamanio = min 10 $ tamanio pizza + 2}

mezcladita primeraPizza segundaPizza =
    segundaPizza{
        ingredientes = mezclaDeIngredientes primeraPizza segundaPizza,
        cantCalorias = calculoCalorias primeraPizza segundaPizza
    }

mezclaDeIngredientes primeraPizza segundaPizza =
    agregarSinRepetir (ingredientes primeraPizza) (ingredientes segundaPizza)

calculoCalorias primeraPizza segundaPizza =
    cantCalorias primeraPizza / 2 + cantCalorias segundaPizza


agregarSinRepetir base agregados =
    foldl agregar base agregados
    where
        agregar base agregado
            |notElem agregado base = agregado : base
            |otherwise = base



