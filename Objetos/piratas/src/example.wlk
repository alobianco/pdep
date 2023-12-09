// Un barco tiene una mision, la cual puede cambiar en cualquier momento
// Un barco tiene tripulantes (Piratas) y puede reclutar mas


// Cada pirata puede llevar items, tiene un nivel de ebriedad
// tambien la cantidad de dinero que tiene (un numero de monedas)

// Misiones, 3 tipos, busqueda de tesoro, convertirse en leyenda y saqueos




// Punto 1 - Saber si un pirata es útil para una misión
// pirata.esUtilPara(mision)
// mision.esUtil(pirata)

//Podemos crear items importantes asi:
class Item{ 
	const property nombre
}
const botellaDeGrogXD = new Item(nombre = "botella de GrogXD")
const mapa = new Item(nombre = "mapa")
const brujula = new Item(nombre = "brujula")
const llaveDeCofre = new Item(nombre = "llave de cobre")
const permisoDeLaCorona = new Item(nombre = "Permiso de la corona")

//----------------------Pirata----------------------//

class Pirata{
	const property items = []
	var property nivelDeEbriedad = 0
	var property monedas = 0
	
	method puedePagar(dinero) = monedas >= dinero
	method tieneItem(item) = items.contains(item)
	
	method cantidadDeItems() = items.size()
	
	method puedeSaquearA(victima) = victima.puedeSerSaqueadoPor(self)
	
	method estaPasadoDeGrogXD() = nivelDeEbriedad >= 90 && self.tieneItem(botellaDeGrogXD)
	
	method tomarTratoDeGrogXD(ciudad){
		self.gastar(ciudad.cuantoCobraElGrogXD())
		nivelDeEbriedad += 5
	}
	
	method gastar(dinero){
		if(self.puedePagar(dinero)){
			monedas -= dinero
		}
		else
			self.error("No se puede pagar esa cantidad de dinero")
	}
}


class EspiaDeLaCorona inherits Pirata{
	override method estaPasadoDeGrogXD() = false
	
	override method puedeSaquearA(victima) = super(victima) && self.tieneItem(permisoDeLaCorona)
}

//----------------------MISIONES----------------------//

class Mision {
	method puedeSerRealizadaPor(barco){
		return barco.superaPorcentajeDeOcupacion(90) && self.cumpleCondicionesParaRealizarla(barco)
	}
	
	method cumpleCondicionesParaRealizarla(barco) = true
	
}


class BusquedaDelTesoro inherits Mision{
	
	method esUtil(pirata) = self.tieneAlgunItemUtil(pirata) && pirata.monedas() <= 5
	
	method tieneAlgunItemUtil(pirata) = 
		#{brujula, mapa, botellaDeGrogXD}.any({item => pirata.tieneItem(item)})
		
	override method cumpleCondicionesParaRealizarla(barco) = barco.tieneItem(llaveDeCofre)
}

class ConvertirseEnLeyenda inherits Mision{
	const property itemObligatorio
	
	method esUtil(pirata) = 
		pirata.cantidadDeItems() >= 10 && pirata.tieneItem(itemObligatorio)
}

class Saqueo inherits Mision{
	//var property maximoMonedas = 0  -- Esto no va, porque tiene que ser el mismo para todos
	const property victima
	method esUtil(pirata) = 
		pirata.monedas() < self.maximoDeMonedas() && pirata.puedeSaquearA(victima)
		
	method maximoDeMonedas() = configuracionSaqueos.maximoDeMonedas()
	
	override method cumpleCondicionesParaRealizarla(barco) = victima.esVulnerableA(barco)
}

object configuracionSaqueos{
	var property maximoDeMonedas = 0
}



class BarcoPirata{
	
	var property mision
	const property capacidad
	const property tripulantes = #{}
	
	method esTemible() = self.puedeRealizarMision() && 
		//tripulantes.filter {pirata => mision.esUtil(pirata)}.size()
		tripulantes.count { pirata => mision.esUtil(pirata) } > 5
		
	method puedeRealizarMision() = mision.puedeSerRealizadaPor(self)
	
	method superaPorcentajeDeOcupacion(porcentaje) = 
		self.cantidadDeTripulantes() >= capacidad * porcentaje / 100
	method tieneItem(item) = 
		tripulantes.any { pirata => pirata.tieneItem(item)}
	method tripulacionPasadaDeGrogXD() = 
		tripulantes.all { pirata => pirata.estaPasadoDeGrogXD()}
	
	method itemMasRaro(item) = self.items().min { items => self.cantidadDeTriupantesQueTienen(items) }
	
	method cantidadDeTriupantesQueTienen(item) = tripulantes.count {tripulante => tripulante.tieneItem(item)}
	
	method items() = self.tripulantes().flatMap {tripulante => tripulante.items()} 
	
	method mision(nuevaMision){
		mision = nuevaMision
 		// echamos a los que no sirven
 		const piratasQueNoSirven = tripulantes.filter({pirata =>
 			not nuevaMision.esUtil(pirata)
 		})
 		tripulantes.removeAll(piratasQueNoSirven)
 	}
	
	method puedeSerSaqueadoPor(pirata) = pirata.estaPasadoDeGrogXD()
	
	method puedeFormarParteDeLaTripulacion(pirata) = self.hayLugar() && mision.esUtil(pirata)
	
	method hayLugar() = capacidad > self.cantidadDeTripulantes()
	
	method cantidadDeTripulantes() = tripulantes.size()
	
	method incorporarATripulacion(pirata){
		if (not self.puedeFormarParteDeLaTripulacion(pirata)){
			self.error("No se puede subir al barco")	
		}
		tripulantes.add(pirata)
	}
	
	method esVulnerableA(barco) = barco.cantidadDeTripulantes() / 2 >= self.cantidadDeTripulantes()
	
	method anclarEn(ciudadCostera){
		tripulantes.filter {tripulante => tripulante.puedePagar(ciudadCostera.cuantoCobraElGrogXD())}.forEach {tripulante => tripulante.tomarTratoDeGrogXD(ciudadCostera)}
		
		
		const elMasEbrio = self.tripulanteMasEbrio()
		tripulantes.remove(elMasEbrio)
		ciudadCostera.sumarHabitante(elMasEbrio)
		
	}
	
	method tripulanteMasEbrio() = tripulantes.max { tripulante => tripulante.nivelDeEbriedad()}
	
	
	

	
}

class CiudadCostera{
	var property cantidadDeHabitantes = 0
	const property cuantoCobraElGrogXD = 0
	method puedeSerSaqueadoPor(pirata) = pirata.nivelDeEbriedad() >= 50
	
	method esVulnerableA(barco) = barco.cantidadDeTripulantes() >= self.cantidadDeHabitantes() * 0.4 || barco.tripulacionPasadaDeGrogXD()
	
	method sumarHabitante(habitante) {
		cantidadDeHabitantes +=1
	}  
}
		


