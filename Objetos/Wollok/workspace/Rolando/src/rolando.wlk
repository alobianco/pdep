 object rolando{
		//Punto 1
		const nivelHechiceriaBase = 3
		var hechizoPreferido = espectroMalefico
	
		//Punto 2
		var nivelLuchaBase = 1
		const artefactos = []
	
		//Punto 1
		method nivelHechiceria() = nivelHechiceriaBase * hechizoPreferido.poderHechizo() + fuerzaOscura.valor()
		method hechizoPreferido(hechizo) { hechizoPreferido = hechizo }
		method poderoso(){
			hechizoPreferido.esPoderoso()
		}
		method seCreePoderoso() = hechizoPreferido.esPoderoso()
		
		//Punto 2
		method nivelLuchaBase(nuevoNivel){ nivelLuchaBase = nuevoNivel }
		method agregarArtefacto(artefacto){
			artefactos.add(artefacto)
		}
		method removerArtefacto(artefacto){
			artefactos.remove(artefacto)
		}
		method valorDeLucha() = nivelLuchaBase + self.aporteDeArtefactos()
		method aporteDeArtefactos() = artefactos.sum{ artefacto => artefacto.unidadesDeLucha(self) }
		method masLuchadorQueHechicero() = self.valorDeLucha() > self.nivelHechiceria()
}

//Punto 1 - Hechizos y Fuerza oscura
object espectroMalefico{
	
	var nombre = "espectro maléfico"
	method poderHechizo() = nombre.length()
	method nombre(nuevoNombre) { nombre = nuevoNombre }
	method esPoderoso() = self.poderHechizo() > 15
}

object hechizoBasico{
	
	method poderHechizo() = 10
	method esPoderoso() = false
}

object fuerzaOscura{
	
	var valor = 5	
	method valor() = valor
	method eclipse(){
		valor *= 2
	}
}

//Punto 2 - Artefactos
object espadaDelDestino{
	
	method unidadesDeLucha(luchador) = 3
}

object collarDivino{
	
	var cantidadDePerlas = 5
	method cantidadDePerlas(perlas){
		cantidadDePerlas = perlas
	}
	method unidadesDeLucha(luchador) = cantidadDePerlas
}

object mascaraOscura{
	
	const unidadMinima = 4
	method unidadesDeLucha(luchador) = unidadMinima.max(fuerzaOscura.valor() / 2)
}

//Punto 3 - Agrego Artefactos y Hechizos
object armadura{
	var refuerzo = hola
	method unidadesDeLucha(luchador) = 2	
}

object cotaDeMalla{
	method valorDeRefuerzo() = 1
}
object bendicion{
	method valorDeRefuerzo() = 
}
