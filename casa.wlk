import cosas.* 
import cuentas.*


object casa {
	const cosas = []
	var property cuenta = cuentaCorriente 

	method cosas() {
	  return cosas
	}

	method comprar(cosa) {
	// registra que se ha comprado una cosa.
	//Va primero la funcion que tiene la validacion

	  cuenta.extraer(cosa.precio())
	  cosas.add(cosa)
	}

	method cantidadDeCosasCompradas() {
	  return cosas.size()
	}

	method tieneAlgun(categoria) {
	  //indica si compró algo que es corresponde a esa categoría alguna vez.
		return cosas.any({cosa => cosa.categoria() == categoria})
	}

	method ultimoComprado() {
	  return cosas.last()
	}
	method vieneDeComprar(categoria){
	//indica si la _última_ cosa que se compró es de la categoría
	// indicada.
		return not cosas.isEmpty() and self.ultimoComprado().categoria() == categoria
	}

	method esDerrochona() {
	  //indica si el importe total de las cosas 
	  //compradas es de 9000 pesos o más.
	  return self.totalComprado() > 9000

	  //return cosas.sum({cosa => cosa.precio()}) SOLUCION EQUIVALENTE, PREFERIBLE POR LO DIRECTO. 
	}

	method totalComprado() {
	  return cosas.map({cosa => cosa.precio()}).sum()
	}

	method compraMasCara() {
	  //retorna la cosa comprada de mayor valor.
	  return cosas.max({cosa => cosa.precio()})
	}
	
	method comprados(categoria) {
	  //devuelve un objeto que contiene todas las cosas 
	  //compradas que de esa categoría. 
	  return cosas.filter({cosa => cosa.categoria() == categoria})
	}

	method malaEpoca() {
	  //indica si todas las cosas compradas son comida. BOOL
	  //return cosas.all({cosa => cosa.categoria() == comida}) es valido pero no es polimorfico
	  return cosas.all({cosa => cosa.categoria().esComestible()})
		//Ahora las categorias tienen esa caracteristica, entienden el mensaje. 
	}

	method queFaltaComprar(lista) {
	  //recibe una lista de cosas y devuelve 
	  //las cosas de esa lista que aún no se han comprado.
	//No se pide que se compren. 
		return lista.filter({cosa => not self.estaComprado(cosa)})
	}

	method estaComprado(cosa) {
	  return cosas.contains(cosa)
	}

	method faltaComida() {
	  //indica si se han comprado menos de 2 cosas 
	  //que son comida. BOOL
	  return self.comprados(comida).size() < 2	//es valida porque ya tengo el filter en el otro metodo
	  // return cosas.count({cosa => cosa.categoria().esComestible()}) < 2   FILTER+SIZE es lo mismo que usar el count
	}

	method categoriasCompradas() {
	  //indica todas las categorías para las cuales 
	  //se ha realizado al menos una compra
	  return cosas.map({cosa => cosa.categoria()}).asSet()

	}

}
