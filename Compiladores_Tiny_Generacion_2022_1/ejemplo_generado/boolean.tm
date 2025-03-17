*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> asignacion
*      -> constante
2:       LDC       0,2(0)      cargar constante: 2
*      <- constante
3:       ST       0,0(5)      asignacion: almaceno el valor para el id variable
*      <- asignacion
*      -> asignacion
*      -> constante booleana
4:       LDC       0,1(0)      cargar constante booleana: true
*      <- constante booleana
5:       ST       0,1(5)      asignacion: almaceno el valor para el id variableBooleana
*      <- asignacion
*      -> escribir
*      -> identificador
6:       LD       0,1(5)      cargar valor de identificador: variableBooleana
*      -> identificador
7:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      Fin de la ejecucion.
8:       HALT       0,0,0