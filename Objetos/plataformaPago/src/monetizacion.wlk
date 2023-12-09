/*
 * 1 - Calcular el total recaudado por un contenido
 * 2 - Hacer que el sistema permita realizar las siguientes consultas:
 * 		a - Saldo total de un usuario, que es la suma total de lo recaudado por todos sus contenidos.
 * 		b - Email de los 100 usuarios verificados con mayor saldo total.
 * 		c - Cantidad de super-usuarios en el sistema (usuarios que tienen al menos 10 contenidos populares publicados).
 * 3 - Permitir que un usuario publique un nuevo contenido, asociándolo a una forma de monetización.
 * 4 - Aparece un nuevo tipo de estrategia de monetización: El Alquiler. 
 * 	   Esta estrategia es muy similar a la venta de descargas, pero los archivos se autodestruyen después de un tiempo. 
 * 	   Los alquileres tienen un precio mínimo de $1.00 y, además de tener todas las restricciones de las ventas, los alquileres sólo pueden aplicarse a videos.
 * 
 */



//-----Contenido-----//

class Contenido{
	const property titulo
	var property vistas = 0
	var property ofensivo = false
	var property monetizacion  // Va a ser un objeto y tiene que cambiar
	
	method monetizacion(nuevaMonetizacion){  // Nuevo setter, para checkear que la monetizacion se pueda aplicar
		if(!nuevaMonetizacion.puedeAplicarseA(self))
			throw new DomainException(message = "Este contenido no soporta la forma de monetizacion")
			
		monetizacion = nuevaMonetizacion
	}
	
	override method initialize(){ //Metodo de inicio al crearse un new Contenido
		if(!nuevaMonetizacion.puedeAplicarseA(self))
			throw new DomainException(message = "Este contenido no soporta la forma de monetizacion")
	}
	
	method recaudacion() = monetizacion.recaudacionDe(self)
	method puedeVenderse() = self.esPopular()
	method esPopular()
	method recaudacionMaximaParaPublicidad()
	
	method puedeAlquilarse()
	
	
}

class Video inherits Contenido{
	
	override method esPopular() = vistas > 10000
	override method recaudacionMaximaParaPublicidad() = 10000
	
	override method puedeAlquilarse() = true
	
	
}
const tagsDeModa = ["algo", "otraCosa"]

class Imagen inherits Contenido{
	const property tags = []
	override method esPopular() = tagsDeModa.all{ tag => tags.contains(tag) }
	override method recaudacionMaximaParaPublicidad() = 4000
	
	override method puedeAlquilarse() = false
	
	
}

//-----Monetizaciones-----//

object publicidad{
	method recaudacionDe(contenido) = (
		0.05 * contenido.vistas() + 			//Se delega al contenido, para cada contenido
		if(contenido.esPopular()) 2000 else 0
		).min(contenido.recaudacionMaximaParaPublicidad())
		
	method puedeAplicarseA(contenido) = !contenido.ofensivo()
	
}

class Donacion{
	var property donaciones = 0
	
	method recaudacionDe(contenido) = donaciones
	
	method puedeAplicarseA(contenido) = true
	
	
}

class Descarga{
	const property precio
	
	override method initialize(){
		if (precio < 5) throw new DomainException(message = "El precio es muy barato, debe ser mayor a 5")
	}
	
	method recaudacionDe(contenido) = contenido.vistas() * precio
	
	method puedeAplicarseA(contenido) = contenido.puedeVenderse()
}

class Alquiler inherits Descarga{
	override method precio() = 1.max(super())
	
	override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse()
}


//-----Usuarios-----//

object usuarios{
	const todosLosUsuarios = []
	
	method emailsDeUsuariosRicos() = todosLosUsuarios
		.filter{usuario => usuario.verificado()}
		.sortedBy{uno, otro => uno.saldoTotal() > otro.saldoTotal()}
		.take(100)
		.map{usuario => usuario.email()}
	method cantidadDeSuperUsuarios() = todosLosUsuarios.count{usuario => usuario.esSuperUsuario()}
}

class Usuario{
	const property nombre
	const property email
	var property verificado = false
	const contenidos = []
	
	method saldoTotal() = contenidos.sum{ contenido => contenido.recaudacion() }
	
	method esSuperUsuario() = contenidos.count{contenido => contenido.esPopular()} >= 10
	
	method publicar(contenido){
		contenidos.add(contenido)
	}
}



