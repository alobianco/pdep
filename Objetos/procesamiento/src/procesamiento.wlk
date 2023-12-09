//------------------------------------------------------------------------------------------------
// Computadora
//------------------------------------------------------------------------------------------------
class SuperComputadora{
	const equipos = []
	var totalDeComplejidadComputada = 0
	
	
	method equiposActivos() = equipos.filter{ equipo => equipo.estaActivo() }
	method estaActivo() = true //Necesita entender este mensaje, porque una supercomputadora, puede ser parte de otra supercomputadora
	method computo() = self.equiposActivos().sum{ equipo => equipo.computo() }
	method consumo() = self.equiposActivos().sum{ equipo => equipo.consumo() }
	
	method malConfigurada() = self.equipoQueMasConsume() != self.equipoQueMasComputa()
	
	method equipoQueMasConsume() = self.equiposActivos().max{ equipo => equipo.consumo() }
	method equipoQueMasComputa() = self.equiposActivos().max{ equipo => equipo.computo() }
	
	method computar(problema){
		self.equiposActivos().forEach{ equipo => 
			equipo.computar(new Problema(complejidad = problema.complejidad() / self.equiposActivos().size()))
		}
		totalDeComplejidadComputada += problema.complejidad()
	}
	
}

class Problema{
	const property complejidad
}

//------------------------------------------------------------------------------------------------
// Modos
//------------------------------------------------------------------------------------------------

object standard{
	method consumoDe(equipo) = equipo.consumoBase()
	method computoDe(equipo) = equipo.computoBase()
	method realizoComputo(equipo){ }
}

class Overclock{
	var usosRestantes
	
	override method initialize(){
		if(usosRestantes < 0) throw new DomainException(message = "Los usos restantes deben ser >= 0")
	}
	method consumoDe(equipo) = equipo.consumoBase() * 2 
	method computoDe(equipo) = equipo.computoBase() + equipo.computoExtraPorOverclock()
	method realizoComputo(equipo){
		if(usosRestantes == 0){
			equipo.estaQuemado(true)
			throw new DomainException(message = "Equipo quemado!")
		}
		usosRestantes -= 1
	}
	
}

class AhorroDeEnergia{
	var computosRealizados = 0
	method consumoDe(equipo) = 200
	method computoDe(equipo) = self.consumoDe(equipo) / equipo.consumoBase() * equipo.computoBase()
	method periodicidadDeError() = 17
	method realizoComputo(equipo){
		computosRealizados += 1
		if(computosRealizados % self.periodicidadDeError() == 0) 
			throw new DomainException(message = "Corriendo monitor")
	}
	
}

class ModoAPruebaDeFallos inherits AhorroDeEnergia{
	override method computoDe(equipo) = super(equipo) / 2
	override method periodicidadDeError() = 100
}

//------------------------------------------------------------------------------------------------
// Equipos
//------------------------------------------------------------------------------------------------
class Equipo{
	var property modo
	var property estaQuemado = false
	
	method estaActivo() = !estaQuemado && self.computo() > 0
	
	method consumo() = modo.consumoDe(self)
	method computo() = modo.computoDe(self)
	
	method consumoBase()
	method computoBase()
	method computoExtraPorOverclock()
	method computar(problema){
		if(problema.complejidad() > self.computo()) throw new DomainException(message = "Capadidad excedida")
		modo.realizoComputo(self)	
	}
	
	
}

class A105 inherits Equipo{
	
	override method consumoBase() = 300
	override method computoBase() = 600
	override method computoExtraPorOverclock() = self.computoBase() * 0.3
	override method computar(problema){
		if(problema.complejidad() < 5) throw new DomainException(message = "Error de fabrica")
		super(problema)
	}
}

class B2 inherits Equipo{
	const microsInstalados
 	override method consumoBase() = 10 + 50 * microsInstalados
	override method computoBase() = 800.min(100*microsInstalados)
	override method computoExtraPorOverclock() = self.computoBase() + 20 * microsInstalados

}