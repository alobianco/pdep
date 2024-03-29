/*
	1 - Se desea conocer la grositud de un pokémon, que se calcula como el producto entre su vida máxima y la suma del poder de sus movimientos. 
	Los movimientos curativos tienen un poder igual a la cantidad de puntos de salud que curan, 
	los dañinos el doble del daño que producen y los especiales un valor que se depende de qué tipo de condición generen: el sueño vale 50 y la parálisis 30.
*/
/*	2 - Uso de movimientos:
		a - Usar un movimiento entre dos pokemones, el que lo realiza y su contrincante. 
			Al usar el movimiento se debe decrementar un uso y aplicar su efecto como corresponda. 
			Para aplicar los efectos deben considerarse todos los tipos de movimientos previamente explicados.
		b - Hacer que un pokémon luche con otro pokémon usando un movimiento de los que tiene disponibles (los que les quedan usos), 
		 	teniendo en cuenta que sólo puede moverse si su vida es mayor a 0 y su condición se lo permite.
			Si el pokemon está afectado por una condición especial, se podría interrumpir el turno sin llegar a usar el movimiento elegido.
*/
/*
	3 - Se agrega una nueva condición especial denominada confusión, que puede durar una cantidad de turnos indicada, luego de los cuales el pokemon se normaliza.
		Cuando un pokémon confundido intenta moverse y no puede, además de no poder usar el movimiento elegido para luchar, se hace daño a sí mismo por 20 puntos de vida. 
		Esta condición tiene un valor de 40 multiplicado por la cantidad de turnos que dure para el cálculo de grositud. 
*/
 
/* PUNTO 1 
 * pokemon.grositud() = vidaMaxima * sumaDePoderDeMovimientos
 */
/* PUNTO 2
 * movimiento.usarEntre(usuario, contrincante)
 */
//----Pokemon----//

class Pokemon{
	const vidaMaxima = 100
	const movimientos = #{}
	var vida = 0
	var property condicion = normal
	
	method grositud() = vidaMaxima * movimientos.sum{ movimiento => movimiento.poder() }
	
	method curar(puntosDeSalud){
		vida = (vida + puntosDeSalud).min(vidaMaxima)
	}
	method recibirDanio(danio){
		vida = 0.max(vida - danio)
	}
	
	method lucharContra(contrincante){
		self.validarQueEstaVivo()
		contrincante.validarQueEstaVivo()
		const movimientoAUsar = self.movimientoDisponible()
		condicion.intentaMoverse(self)
		movimientoAUsar.usarEntre(self,contrincante)
	}
	
	method movimientoDisponible() = 
		movimientos.findOrElse ({ movimiento => movimiento.estaDisponible() }, 
		{throw new NoPuedeMoverseException(message = "No tiene movimientos disponibles")})
	
	method normalizar() {
		condicion = normal
	}
	
	method validarQueEstaVivo() {
		if(vida == 0){
			throw new NoPuedeMoverseException(message = "El pokemon no esta vivo")
		}
	}
}

//----Movimientos----//

class Movimiento{
	var usosPendientes = 0
	method usarEntre(usuario, contrincante){
		if(! self.estaDisponible())
			throw new MovimientoAgotadoException(message = "El movimiento no está disponible")
		usosPendientes -= 1
		self.afectarPokemones(usuario, contrincante)
	}
	
	method estaDisponible() = usosPendientes > 0
	
	method afectarPokemones(usuario, contrincante)
}

class MovimientoCurativo inherits Movimiento{
	const puntosDeSalud
	
	method poder() = puntosDeSalud
	
	override method afectarPokemones(usuario, contrincante){
		usuario.curar(puntosDeSalud)
	}
	
	
}
class MovimientoDanino inherits Movimiento{
	const danioQueProduce
	
	method poder() = danioQueProduce * 2
	
	override method afectarPokemones(usuario, contrincante){
		contrincante.recibirDanio(danioQueProduce)
		
	}
	
}
class MovimientoEspecial inherits Movimiento{
	const condicionQueGenera
	
	method poder() = condicionQueGenera.poder()
	
	override method afectarPokemones(usuario, contrincante){
		contrincante.condicion(condicionQueGenera)		
	}
	
}
// CONDICION NORMAL
object normal{
	method intentaMoverse(pokemon){
		
	}
}

// CONDICIONES MOVIMIENTO ESPECIAL //
class CondicionEspecial{
	
	method intentaMoverse(pokemon){
		if (! self.lograMoverse())
			throw new NoPuedeMoverseException(message = "El pokemon no pudo moverse")
	}
	
	method lograMoverse() = 0.randomUpTo(2).roundUp().even()
	
	method poder()
}
object paralisis inherits CondicionEspecial{
	override method poder() = 30
}

object suenio inherits CondicionEspecial{
	override method poder() = 50
	
	override method intentaMoverse(pokemon){
		super(pokemon)
		pokemon.normalizar()
	}
		
}

class Confusion inherits CondicionEspecial{
	const turnosQueDura = 0
	
	override method poder() = 40 * turnosQueDura
	override method intentaMoverse(pokemon){
		try{
			super(pokemon)
			self.pasoUnTurno(pokemon)
		}
		catch e : NoPuedeMoverseException {
			pokemon.recibirDanio(20)
			self.pasoUnTurno(pokemon)
			throw new NoPuedeMoverseException(message = "EL pokemon no pudo moverse y se hizo daño a si mismo")
		}	
	}
	
	method pasoUnTurno(pokemon){
		if(turnosQueDura > 1){
			pokemon.condicion(new Confusion(turnosQueDura = turnosQueDura - 1))
		} else {
			pokemon.normalizar()
		}
	}
}








// EXCEPTIONS

class MovimientoAgotadoException inherits Exception{}
class NoPuedeMoverseException inherits Exception{}











