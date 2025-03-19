*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> leer
2:       IN       0,0,0      leer: lee un valor entero 
3:       ST       0,0(5)      leer: almaceno el valor entero leido en el id vari
*      <- leer
*      -> if
*      -> Operacion: mayor
*      -> identificador
4:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
5:       ST       0,0(6)      op: push en la pila tmp el resultado expresion izquierda
*      -> constante
6:       LDC       0,10(0)      cargar constante: 10
*      <- constante
7:       LD       1,0(6)      op: pop o cargo de la pila el valor izquierdo en AC1
8:       SUB       0,1,0      op: >
9:       JGT       0,2(7)      voy dos instrucciones mas alla if verdadero (AC>0)
10:       LDC       0,0(0)      caso de falso (AC=0)
11:       LDA       7,1(7)      Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)
12:       LDC       0,1(0)      caso de verdadero (AC=1)
*      <- Operacion: mayor
*      If: el salto hacia el else debe estar aqui
*      -> escribir
*      -> constante
14:       LDC       0,1(0)      cargar constante: 1
*      <- constante
15:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
16:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
17:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
18:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
19:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
20:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
21:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
22:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
23:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
24:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
25:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> identificador
26:       LD       0,0(5)      cargar valor de identificador: vari
*      -> identificador
27:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      If: el salto hacia el final debe estar aqui
13:       JEQ       0,15(7)      if: jmp hacia else
*      <- if
*      Fin de la ejecucion.
29:       HALT       0,0,0