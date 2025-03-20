*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> leer
2:       IN       0,0,0      leer: lee un valor entero
3:       ST       0,0(5)      leer: almaceno el valor entero leido en el id hola
*      <- leer
*      -> escribir
*      -> identificador
4:       LD       0,0(5)      cargar valor de identificador: hola
*      -> identificador
5:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> Operacion: por
*      -> identificador
6:       LD       0,0(5)      cargar valor de identificador: hola
*      -> identificador
7:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
8:       LDC       0,5(0)      cargar constante: 5
*      <- constante
9:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
10:       MUL       0,1,0      op: *
11:       MUL       0,1,0      op: and
*      <- Operacion: por
*      Asignación normal a variable: hola
12:       ST       0,0(5)      asignacion: almaceno el valor para el id hola
*      <- asignacion
*      -> escribir
*      -> identificador
13:       LD       0,0(5)      cargar valor de identificador: hola
*      -> identificador
14:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
15:       LDC       0,0(0)      cargar constante: 0
*      <- constante
*      Asignación normal a variable: fact
16:       ST       0,1(5)      asignacion: almaceno el valor para el id fact
*      <- asignacion
*      for: el salto hacia el final (luego del cuerpo) del repeat debe estar aqui
*      -> Operacion: menos
*      -> identificador
17:       LD       0,1(5)      cargar valor de identificador: fact
*      -> identificador
18:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
19:       LDC       0,10(0)      cargar constante: 10
*      <- constante
20:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
21:       SUB       0,1,0      op: -
*      <- Operacion: menos
*      -> asignacion
*      -> Operacion: mas
*      -> identificador
23:       LD       0,1(5)      cargar valor de identificador: fact
*      -> identificador
24:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
25:       LDC       0,2(0)      cargar constante: 2
*      <- constante
26:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
27:       ADD       0,1,0      op: +
28:       ADD       0,1,0      op: or
29:       JGT       0,2(7)      Si AC>0, es verdadero
30:       LDC       0,0(0)      Caso falso (AC=0)
31:       LDA       7,1(7)      Salto incondicional
32:       LDC       0,1(0)      Caso verdadero (AC=1)
*      <- Operacion: mas
*      Asignación normal a variable: fact
33:       ST       0,1(5)      asignacion: almaceno el valor para el id fact
*      <- asignacion
*      -> escribir
*      -> identificador
34:       LD       0,1(5)      cargar valor de identificador: fact
*      -> identificador
35:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> Operacion: mas
*      -> identificador
36:       LD       0,1(5)      cargar valor de identificador: fact
*      -> identificador
37:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
38:       LDC       0,1(0)      cargar constante: 1
*      <- constante
39:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
40:       ADD       0,1,0      op: +
41:       ADD       0,1,0      op: or
42:       JGT       0,2(7)      Si AC>0, es verdadero
43:       LDC       0,0(0)      Caso falso (AC=0)
44:       LDA       7,1(7)      Salto incondicional
45:       LDC       0,1(0)      Caso verdadero (AC=1)
*      <- Operacion: mas
*      Asignación normal a variable: fact
46:       ST       0,1(5)      asignacion: almaceno el valor para el id fact
*      <- asignacion
47:       LDA       7,-31(7)      for: jmp hacia la prueba
22:       JGT       0,25(7)      for: jmp hacia el final
*      Fin de la ejecucion.
48:       HALT       0,0,0