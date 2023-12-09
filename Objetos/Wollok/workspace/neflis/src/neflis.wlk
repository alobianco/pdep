//----------Personas----------//
object cosmeFulanito {
	const planContratado = planBasico
	const property preferencias = #{"Accion", "Aventuras"}
	var property contenidoVisto = []
	method puedeVer(contenido) = planContratado.perteneceAPlan(contenido)
	
	method vioContenido(contenido) {
		if(self.puedeVer(contenido)){
			contenidoVisto.add(contenido)
		}
	}
	 method valoracion() {
		if (contenidoVisto.size() == 0) {return 0}
		const sumValoracion = contenidoVisto.map({ contenido => contenido.valoracion()}).sum()
		return sumValoracion / contenidoVisto.size()
	}
	
	method preferencias (genero) {preferencias.add(genero)}
	
	method veria(contenido) {
		const tipoContenido = contenido.tipo()
		const generosContenido = contenido.generos()
				
		if (tipoContenido == "Película" || tipoContenido == "Serie") 
		{
			return generosContenido.any ({ genero => preferencias.contains(genero) })
		} else if (tipoContenido == "Documental") {
			return generosContenido.contains("Documental") && generosContenido.any ({ genero => preferencias.contains(genero) })
		} else {
			return false
		}
	}
	
	
}

object margoZavala{
	const planContratado = planPremium
	var property desvio
	var property contenidoVisto = []
	method puedeVer(contenido) = planContratado.perteneceAPlan(contenido)
	
	method vioContenido(contenido){
		if(self.puedeVer(contenido)){
			contenidoVisto.add(contenido)
		}
	}
	method valoracion() {
		if (contenidoVisto.size() == 0) {return 0}
		const sumValoracion = contenidoVisto.map({ contenido => contenido.valoracion()}).sum()
		return sumValoracion / contenidoVisto.size()
	}
	method veria(contenido){
	 	if (self.valoracion()==0){
	 		return true
		} else{		
			return contenido.valoracion().between(self.valoracion() * ( 1 - desvio), self.valoracion() * ( 1 + desvio) )
		}
	 }
	 
	 method desvio (_desvio) {desvio = _desvio}
}


//----------Contenido----------//

object blackSails{
	const tipo = "Serie"
	const temporadas = 4
	const capitulosPorTemporada = 8
	const property genero = #{"Accion"}
	
	method valoracion() = temporadas * capitulosPorTemporada
	
	method perteneceAPlanBasico() = true
	
}
object avengersEndgame{
	const tipo = "Pelicula"
	const property genero = #{"Accion", "Drama", "Aventuras"}
	
	method valoracion() = genero.size() * 12
	
	method perteneceAPlanBasico() = true
	
}
object seanEternos{
	const tipo = "Documental"
	const property genero = #{"Fulbo"}
	
	method valoracion() = 100
	
	method perteneceAPlanBasico() = true
	
}
object planBasico{
	method perteneceAPlan(contenido){return contenido.perteneceAPlanBasico() }
}
object planPremium{
	method perteneceAPlan(contenido) = true
}