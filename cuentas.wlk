object cuentaCorriente {
  var property saldo = 0

  method depositar(monto) {
    saldo += monto
    
  }
//Si hay mas de una validacion relacionada, es mejor agruparlas en una sola para mantener el codigo limpio
  method validarExtraccion(monto) {
    if (monto > saldo){
        self.error("El saldo " + saldo + " es insuficiente para extraer " + monto)
    }
    
  }

  method extraer(monto) {
    self.validarExtraccion(monto)   //si validar no pasa, se corta la ejecucion y no llega a la extraccion
    //Despues de la validacion va la logica de negocios.
    //Al ocurrir una excepcion en la validacion, el estado no se altero.
    saldo -= monto

    // if (monto <= saldo ){
    // saldo -= monto
    // }else{
    //     self.error("El saldo " + saldo + " es insuficiente para extraer " + monto )
    // }

    //self.error("mensaje")
  }
}

object cuentaConGastos {
  var property saldo = 0
  var property costo = 20 

  method depositar(monto) {
    saldo += (monto - costo).max(0)
    
  }
   method extraer(monto) {
    saldo -= monto
    
  }
}

object cuentaCombinada {
    var property primaria = cuentaCorriente
    var property secundaria = cuentaConGastos

    method saldo() {
      return primaria.saldo() + secundaria.saldo()
    }

    method depositar(monto){
        primaria.depositar(monto)
    }

    method extraer(monto) {
        //el if puede ser una expresion para seleccionar un objeto
      const cuenta = if (primaria.saldo() >= monto) primaria else secundaria
      cuenta.extraer(monto)
    }
  
}

