*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> asignacion
*      -> constante
2:       LDC       0,5(0)      cargar constante: 5
*      <- constante
3:       ST       0,0(5)      asignacion: almaceno el valor para el id a
*      <- asignacion
*      -> asignacion
*      -> constante
4:       LDC       0,6(0)      cargar constante: 6
*      <- constante
5:       ST       0,1(5)      asignacion: almaceno el valor para el id b
*      <- asignacion
*      -> asignacion
*      -> Operacion: mas
*      -> identificador
6:       LD       0,0(5)      cargar valor de identificador: a
*      -> identificador
7:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> identificador
8:       LD       0,1(5)      cargar valor de identificador: b
*      -> identificador
9:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
10:       ADD       0,1,0      op: +
*      <- Operacion: mas
11:       ST       0,2(5)      asignacion: almaceno el valor para el id c
*      <- asignacion
*      -> escribir
*      -> identificador
12:       LD       0,2(5)      cargar valor de identificador: c
*      -> identificador
13:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      Fin de la ejecucion.
14:       HALT       0,0,0