
*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> asignacion
*      -> constante
2:       LDC       0,2(0)      cargar constante: 2
*      <- constante
3:       ST       0,0(5)      asignacion: almaceno el valor para el id i
*      <- asignacion
*      for: el salto hacia el final (luego del cuerpo) del repeat debe estar aqui
*      -> Operacion: menos
*      -> identificador
4:       LD       0,0(5)      cargar valor de identificador: i
*      -> identificador
5:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
6:       LDC       0,4(0)      cargar constante: 4
*      <- constante
7:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
8:       SUB       0,1,0      op: -
*      <- Operacion: menos
*      -> asignacion
*      -> constante
10:       LDC       0,0(0)      cargar constante: 0
*      <- constante
11:       ST       0,1(5)      asignacion: almaceno el valor para el id j
*      <- asignacion
*      for: el salto hacia el final (luego del cuerpo) del repeat debe estar aqui
*      -> Operacion: menos
*      -> identificador
12:       LD       0,1(5)      cargar valor de identificador: j
*      -> identificador
13:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
14:       LDC       0,2(0)      cargar constante: 2
*      <- constante
15:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
16:       SUB       0,1,0      op: -
*      <- Operacion: menos
*      -> escribir
*      -> identificador
18:       LD       0,0(5)      cargar valor de identificador: i
*      -> identificador
19:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
20:       LD       0,1(5)      cargar valor de identificador: j
*      -> identificador
21:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> Operacion: mas
*      -> identificador
22:       LD       0,1(5)      cargar valor de identificador: j
*      -> identificador
23:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
24:       LDC       0,1(0)      cargar constante: 1
*      <- constante
25:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
26:       ADD       0,1,0      op: +
*      <- Operacion: mas
27:       ST       0,1(5)      asignacion: almaceno el valor para el id j
*      <- asignacion
28:       LDA       7,-17(7)      for: jmp hacia la prueba
17:       JGT       0,11(7)      for: jmp hacia el final
*      -> asignacion
*      -> Operacion: mas
*      -> identificador
29:       LD       0,0(5)      cargar valor de identificador: i
*      -> identificador
30:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
31:       LDC       0,1(0)      cargar constante: 1
*      <- constante
32:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
33:       ADD       0,1,0      op: +
*      <- Operacion: mas
34:       ST       0,0(5)      asignacion: almaceno el valor para el id i
*      <- asignacion
35:       LDA       7,-32(7)      for: jmp hacia la prueba
9:       JGT       0,26(7)      for: jmp hacia el final
*      Fin de la ejecucion.
36:       HALT       0,0,0      