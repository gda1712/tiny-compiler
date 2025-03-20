*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> asignacion
*      -> constante
2:       LDC       0,2(0)      cargar constante: 2
*      <- constante
*      Asignación normal a variable: i
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
*      Asignación normal a variable: j
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
27:       ADD       0,1,0      op: or
28:       JGT       0,2(7)      Si AC>0, es verdadero
29:       LDC       0,0(0)      Caso falso (AC=0)
30:       LDA       7,1(7)      Salto incondicional
31:       LDC       0,1(0)      Caso verdadero (AC=1)
*      <- Operacion: mas
*      Asignación normal a variable: j
32:       ST       0,1(5)      asignacion: almaceno el valor para el id j
*      <- asignacion
33:       LDA       7,-22(7)      for: jmp hacia la prueba
17:       JGT       0,16(7)      for: jmp hacia el final
*      -> asignacion
*      -> Operacion: mas
*      -> identificador
34:       LD       0,0(5)      cargar valor de identificador: i
*      -> identificador
35:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
36:       LDC       0,1(0)      cargar constante: 1
*      <- constante
37:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
38:       ADD       0,1,0      op: +
39:       ADD       0,1,0      op: or
40:       JGT       0,2(7)      Si AC>0, es verdadero
41:       LDC       0,0(0)      Caso falso (AC=0)
42:       LDA       7,1(7)      Salto incondicional
43:       LDC       0,1(0)      Caso verdadero (AC=1)
*      <- Operacion: mas
*      Asignación normal a variable: i
44:       ST       0,0(5)      asignacion: almaceno el valor para el id i
*      <- asignacion
45:       LDA       7,-42(7)      for: jmp hacia la prueba
9:       JGT       0,36(7)      for: jmp hacia el final
*      Fin de la ejecucion.
46:       HALT       0,0,0