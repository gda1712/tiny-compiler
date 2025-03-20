*      Compilacion TINY para el codigo objeto TM
*      Archivo: NOMBRE_ARREGLAR
*      Preludio estandar:
0:       LD       6,0(0)      cargar la maxima direccion desde la localidad 0
1:       ST       0,0(0)      limpio el registro de la localidad 0
*      -> Declaración de array: nuevoArray
*      Array nuevoArray de tamaño 5 en 0
*      <- Declaración de array
*      -> asignacion a array
*      -> constante
2:       LDC       0,1(0)      cargar constante: 1
*      <- constante
3:       ST       0,0(6)      Guardar valor temporal
4:       LDC       1,0(0)      Cargar dirección base del array nuevoArray
*      -> constante
5:       LDC       0,0(0)      cargar constante: 0
*      <- constante
6:       ADD       0,1,0      Calcular dirección efectiva en el array nuevoArray
7:       LD       1,0(6)      Recuperar valor de la pila
8:       ST       1,0(0)      Guardar valor en el array nuevoArray
*      <- asignacion a array
*      -> asignacion a array
*      -> constante
9:       LDC       0,2(0)      cargar constante: 2
*      <- constante
10:       ST       0,0(6)      Guardar valor temporal
11:       LDC       1,0(0)      Cargar dirección base del array nuevoArray
*      -> constante
12:       LDC       0,1(0)      cargar constante: 1
*      <- constante
13:       ADD       0,1,0      Calcular dirección efectiva en el array nuevoArray
14:       LD       1,0(6)      Recuperar valor de la pila
15:       ST       1,0(0)      Guardar valor en el array nuevoArray
*      <- asignacion a array
*      -> asignacion a array
*      -> constante
16:       LDC       0,55(0)      cargar constante: 55
*      <- constante
17:       ST       0,0(6)      Guardar valor temporal
18:       LDC       1,0(0)      Cargar dirección base del array nuevoArray
*      -> constante
19:       LDC       0,4(0)      cargar constante: 4
*      <- constante
20:       ADD       0,1,0      Calcular dirección efectiva en el array nuevoArray
21:       LD       1,0(6)      Recuperar valor de la pila
22:       ST       1,0(0)      Guardar valor en el array nuevoArray
*      <- asignacion a array
*      -> escribir
*      -> Acceso a array: nuevoArray
*      -> constante
23:       LDC       0,0(0)      cargar constante: 0
*      <- constante
24:       LDC       1,0(0)      Cargar dirección base del array nuevoArray
25:       ADD       1,1,0      Cálculo de dirección del array nuevoArray
26:       LD       0,0(1)      Carga del valor del array nuevoArray
*      <- Acceso a array
27:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> Acceso a array: nuevoArray
*      -> constante
28:       LDC       0,1(0)      cargar constante: 1
*      <- constante
29:       LDC       1,0(0)      Cargar dirección base del array nuevoArray
30:       ADD       1,1,0      Cálculo de dirección del array nuevoArray
31:       LD       0,0(1)      Carga del valor del array nuevoArray
*      <- Acceso a array
32:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      -> escribir
*      -> Acceso a array: nuevoArray
*      -> constante
33:       LDC       0,4(0)      cargar constante: 4
*      <- constante
34:       LDC       1,0(0)      Cargar dirección base del array nuevoArray
35:       ADD       1,1,0      Cálculo de dirección del array nuevoArray
36:       LD       0,0(1)      Carga del valor del array nuevoArray
*      <- Acceso a array
37:       OUT       0,0,0      escribir: genero la salida de la expresion
*      <- escribir
*      Fin de la ejecucion.
38:       HALT       0,0,0