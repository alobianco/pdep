/** Ejemplo integrador clase 3 */
// Nuestro primer heroe
object shrek{
	const misiones =  #{}
	method agregarMision(mision){ misiones.add(mision)}
	method cantidadDeMisiones() = misiones.size()
	method misionesDificiles() = 
		misiones.filter({ mision => mision.esDificil() })
	method solicitanteDeMisMisiones() =
		misiones.map({ mision => mision.solicitante() })
	method totalPuntosDeRecompensa() = 
		misiones.sum({ mision => mision.puntosRecompensa() })
}

/**Primera mision*/
object liberarAFiona{
	var cantidadTrolls = 5
	method puntosRecompensa() = cantidadTrolls * 2
	method esDificil() = cantidadTrolls.between(4,5)
	method solicitante() = "Lord Farquaad"
}

/**Segunda mision */
object buscarPiedraFilosofal{
	var kilometrosDistancia = 40
	method puntosRecompensa() = 
		if(kilometrosDistancia > 50) 10 else 5
	method esDificil() = kilometrosDistancia > 100
	method solicitante() = "Mr DumblecofcofDore"
}



