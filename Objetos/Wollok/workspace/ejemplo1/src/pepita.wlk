/** First Wollok example */
object pepita { //Nuevo objeto de nombre pepita, entre llaves esta su comportamiento y atributos
	var energia = 100 //Variable con un valor asignado
	method volar(kms){ //No tiene parametros, entre llaves esta su comportamiento
		energia = energia - (kms + 10) //Comportamiento de volar
	}
	method comer(gramos){ //Su parametro es "cantidad" se necesita para calcular su comportamiento
		energia = energia + 4 * gramos //Comportamiento de comer
	}
	method energia (){ //Getter de energia, lo muestra
		return energia 
	}
	method energia(energiaNueva){ //Setter de energia, lo setea y puede o no mostrarlo, cambia algo interno
		energia = energiaNueva
	}
	method esFuerte(){ return energia > 50 }
}

/*object juan{
	var mascota
	
	method mascota(_mascota){
		mascota = _mascota
	}
}

object firulais{
	var duenio
	
	method duenio(_duenio){
		duenio = _duenio
	}
}*/

//Otra forma - aca ya tenes que el dueno de la mascota que pasemos es juan, pero esto puede traer problemas si lo queremos asignar del otro lado
object juan{
	var mascota
	
	method mascota(_mascota){
		mascota = _mascota
		mascota.duenio(self)
	}
}

object firulais{
	var duenio
	
	method duenio(_duenio){
		duenio = _duenio
	}
}

object galvan {
	var sueldo = 15000
	
	method sueldo() = sueldo
	
	method sueldo(_sueldo) { sueldo = _sueldo }
}

object baigorria {
	var cantidadEmpanadasVendidas = 100
	const montoPorEmpanada = 15
	
	method venderEmpanada() {
	cantidadEmpanadasVendidas = cantidadEmpanadasVendidas + 1 
}
	
	method sueldo() = cantidadEmpanadasVendidas * montoPorEmpanada
}

object gimenez {
   var dinero = 300000
	
   method dinero() = dinero 
   method pagarA(empleado) { dinero = dinero - empleado.sueldo() }
}




