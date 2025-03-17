*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> leer
2:       IN       0,0,0      leer: lee un valor entero
3:       ST       0,0(5)      leer: almaceno el valor entero leido en el id variable
*      <- leer
*      -> if
*      -> Operacion: menor
*      -> identificador
4:       LD       0,0(5)      cargar valor de identificador: variable
*      -> identificador
5:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
6:       LDC       0,10(0)      cargar constante: 10
*      <- constante
7:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
8:       SUB       0,1,0      op: <
9:       JLT       0,2(7)      voy dos instrucciones mas alla if verdadero (AC<0)
10:       LDC       0,0(0)      caso de falso (AC=0)
11:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
12:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: menor
*      If: Salto al ELSE si condición es falsa
*      -> escribir
*      -> constante
14:       LDC       0,1(0)      cargar constante: 1
*      <- constante
15:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
16:       LDC       0,1(0)      cargar constante: 1
*      <- constante
17:       ST       0,1(5)      asignacion: almaceno el valor para el id resultado
*      <- asignacion
*      If: Salto al FIN después del THEN
13:       JEQ       0,5(7)      If: Saltar al ELSE
18:       LDA       7,0(7)      If: Saltar al FIN
*      <- if
*      -> if
*      -> Operacion: mayor
*      -> identificador
19:       LD       0,0(5)      cargar valor de identificador: variable
*      -> identificador
20:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
21:       LDC       0,10(0)      cargar constante: 10
*      <- constante
22:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
23:       SUB       0,1,0      op: >
24:       JGT       0,2(7)      voy dos instrucciones mas alla if verdadero (AC>0)
25:       LDC       0,0(0)      caso de falso (AC=0)
26:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
27:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: mayor
*      If: Salto al ELSE si condición es falsa
*      -> escribir
*      -> constante
29:       LDC       0,2(0)      cargar constante: 2
*      <- constante
30:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
31:       LDC       0,2(0)      cargar constante: 2
*      <- constante
32:       ST       0,1(5)      asignacion: almaceno el valor para el id resultado
*      <- asignacion
*      If: Salto al FIN después del THEN
28:       JEQ       0,5(7)      If: Saltar al ELSE
33:       LDA       7,0(7)      If: Saltar al FIN
*      <- if
*      -> if
*      -> Operacion: igual
*      -> identificador
34:       LD       0,0(5)      cargar valor de identificador: variable
*      -> identificador
35:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
36:       LDC       0,10(0)      cargar constante: 10
*      <- constante
37:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
38:       SUB       0,1,0      op: ==
39:       JEQ       0,2(7)      voy dos instrucciones mas alla if verdadero (AC==0)
40:       LDC       0,0(0)      caso de falso (AC=0)
41:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
42:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: igual
*      If: Salto al ELSE si condición es falsa
*      -> escribir
*      -> constante
44:       LDC       0,3(0)      cargar constante: 3
*      <- constante
45:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
46:       LDC       0,3(0)      cargar constante: 3
*      <- constante
47:       ST       0,1(5)      asignacion: almaceno el valor para el id resultado
*      <- asignacion
*      If: Salto al FIN después del THEN
43:       JEQ       0,5(7)      If: Saltar al ELSE
48:       LDA       7,0(7)      If: Saltar al FIN
*      <- if
*      -> if
*      -> Operacion: noIgual
*      -> identificador
49:       LD       0,0(5)      cargar valor de identificador: variable
*      -> identificador
50:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
51:       LDC       0,10(0)      cargar constante: 10
*      <- constante
52:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
53:       SUB       0,1,0      op: <>
54:       JNE       0,2(7)      voy dos instrucciones mas alla if verdadero (AC<>0)
55:       LDC       0,0(0)      caso de falso (AC=0)
56:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
57:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: noIgual
*      If: Salto al ELSE si condición es falsa
*      -> escribir
*      -> constante
59:       LDC       0,4(0)      cargar constante: 4
*      <- constante
60:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
61:       LDC       0,4(0)      cargar constante: 4
*      <- constante
62:       ST       0,1(5)      asignacion: almaceno el valor para el id resultado
*      <- asignacion
*      If: Salto al FIN después del THEN
58:       JEQ       0,5(7)      If: Saltar al ELSE
63:       LDA       7,0(7)      If: Saltar al FIN
*      <- if
*      -> if
*      -> Operacion: menorIgual
*      -> identificador
64:       LD       0,0(5)      cargar valor de identificador: variable
*      -> identificador
65:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
66:       LDC       0,10(0)      cargar constante: 10
*      <- constante
67:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
68:       SUB       0,1,0      op: <=
69:       JLE       0,2(7)      voy dos instrucciones mas alla if verdadero (AC<=0)
70:       LDC       0,0(0)      caso de falso (AC=0)
71:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
72:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: menorIgual
*      If: Salto al ELSE si condición es falsa
*      -> escribir
*      -> constante
74:       LDC       0,5(0)      cargar constante: 5
*      <- constante
75:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
76:       LDC       0,5(0)      cargar constante: 5
*      <- constante
77:       ST       0,1(5)      asignacion: almaceno el valor para el id resultado
*      <- asignacion
*      If: Salto al FIN después del THEN
73:       JEQ       0,5(7)      If: Saltar al ELSE
78:       LDA       7,0(7)      If: Saltar al FIN
*      <- if
*      -> if
*      -> Operacion: mayorIgual
*      -> identificador
79:       LD       0,0(5)      cargar valor de identificador: variable
*      -> identificador
80:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
81:       LDC       0,10(0)      cargar constante: 10
*      <- constante
82:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
83:       SUB       0,1,0      op: >=
84:       JGE       0,2(7)      voy dos instrucciones mas alla if verdadero (AC>=0)
85:       LDC       0,0(0)      caso de falso (AC=0)
86:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
87:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: mayorIgual
*      If: Salto al ELSE si condición es falsa
*      -> escribir
*      -> constante
89:       LDC       0,6(0)      cargar constante: 6
*      <- constante
90:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> asignacion
*      -> constante
91:       LDC       0,6(0)      cargar constante: 6
*      <- constante
92:       ST       0,1(5)      asignacion: almaceno el valor para el id resultado
*      <- asignacion
*      If: Salto al FIN después del THEN
88:       JEQ       0,5(7)      If: Saltar al ELSE
93:       LDA       7,0(7)      If: Saltar al FIN
*      <- if
*      -> escribir
*      -> identificador
94:       LD       0,1(5)      cargar valor de identificador: resultado
*      -> identificador
95:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      Fin de la ejecucion.
96:       HALT       0,0,0