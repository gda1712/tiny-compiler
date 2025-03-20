package ve.edu.unet;

import ve.edu.unet.nodosAST.*;

public class Generador {
    /* Ilustracion de la disposicion de la memoria en
     * este ambiente de ejecucion para el lenguaje Tiny
     *
     * |t1	|<- mp (Maxima posicion de memoria de la TM
     * |t1	|<- desplazamientoTmp (tope actual)
     * |free|
     * |free|
     * |...	|
     * |x	|
     * |y	|<- gp
     *
     * */


    /* desplazamientoTmp es una variable inicializada en 0
     * y empleada como el desplazamiento de la siguiente localidad
     * temporal disponible desde la parte superior o tope de la memoria
     * (la que apunta el registro MP).
     *
     * - Se decrementa (desplazamientoTmp--) despues de cada almacenamiento y
     *
     * - Se incrementa (desplazamientoTmp++) despues de cada eliminacion/carga en
     *   otra variable de un valor de la pila.
     *
     * Pudiendose ver como el apuntador hacia el tope de la pila temporal
     * y las llamadas a la funcion emitirRM corresponden a una inserccion
     * y extraccion de esta pila
     */
    private static int desplazamientoTmp = 0;
    private static TablaSimbolos tablaSimbolos = null;

    public static void setTablaSimbolos(TablaSimbolos tabla) {
        tablaSimbolos = tabla;
    }

    public static void generarCodigoObjeto(NodoBase raiz) {
        System.out.println();
        System.out.println();
        System.out.println("------ CODIGO OBJETO DEL LENGUAJE TINY GENERADO PARA LA TM ------");
        System.out.println();
        System.out.println();
        generarPreludioEstandar();
        generar(raiz);
        /*Genero el codigo de finalizacion de ejecucion del codigo*/
        UtGen.emitirComentario("Fin de la ejecucion.");
        UtGen.emitirRO("HALT", 0, 0, 0, "");
        System.out.println();
        System.out.println();
        System.out.println("------ FIN DEL CODIGO OBJETO DEL LENGUAJE TINY GENERADO PARA LA TM ------");
    }

    //Funcion principal de generacion de codigo
    //prerequisito: Fijar la tabla de simbolos antes de generar el codigo objeto
    private static void generar(NodoBase nodo) {
        if (tablaSimbolos != null) {
            if (nodo instanceof NodoIf) {
                generarIf(nodo);
            } else if (nodo instanceof NodoRepeat) {
                generarRepeat(nodo);
            } else if (nodo instanceof NodoAsignacion) {
                generarAsignacion(nodo);
            } else if (nodo instanceof NodoAsignacionArray) {  // <-- ¡Nuevo caso agregado!
                generarAsignacion(nodo);
            } else if (nodo instanceof NodoLeer) {
                generarLeer(nodo);
            } else if (nodo instanceof NodoEscribir) {
                generarEscribir(nodo);
            } else if (nodo instanceof NodoValor) {
                generarValor(nodo);
            } else if (nodo instanceof NodoValorBoolean) {
                generarValorBoolean(nodo);
            } else if (nodo instanceof NodoIdentificador) {
                generarIdentificador(nodo);
            } else if (nodo instanceof NodoOperacion) {
                generarOperacion(nodo);
            } else if (nodo instanceof NodoFor) {
				generarFor(nodo);
            }  else if (nodo instanceof NodoArray) {
                generarArray(nodo);
            } else if (nodo instanceof NodoAccesoArray) {
                generarAccesoArray(nodo);
            } else if (nodo instanceof NodoComentario) {
                generarComentario(nodo);
            } else {
                System.out.println("BUG: Tipo de nodo a generar desconocido");
            }
            /*Si el hijo de extrema izquierda tiene hermano a la derecha lo genero tambien*/
            if (nodo.TieneHermano())
                generar(nodo.getHermanoDerecha());
        } else
            System.out.println("���ERROR: por favor fije la tabla de simbolos a usar antes de generar codigo objeto!!!");
    }

    private static void generarComentario(NodoBase nodo) {
        NodoComentario n = (NodoComentario) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> comentario");
        UtGen.emitirComentario(n.getComentario());
        if (UtGen.debug) UtGen.emitirComentario("<- comentario");
    }


    private static void generarFor(NodoBase nodo){
        NodoFor n = (NodoFor) nodo;
        int localidadSaltoInicio, localidadSaltoEnd, localidadActual;
        generar(n.getAsignacion());
        String variable = ((NodoAsignacion)n.getAsignacion()).getIdentificador();
        localidadSaltoInicio = UtGen.emitirSalto(0);
        UtGen.emitirComentario("for: el salto hacia el final (luego del cuerpo) del repeat debe estar aqui");

        /* Crear la prueba */
        NodoOperacion prueba = new NodoOperacion(new NodoIdentificador(variable), tipoOp.menos, n.getExpresion());
        generar(prueba);
        localidadSaltoEnd = UtGen.emitirSalto(1);

        /* Cuerpo  */
        generar(n.getCuerpo());
        /* Incrementar el for */
        NodoOperacion nodoOperacion = new NodoOperacion(new NodoIdentificador(variable), tipoOp.mas, new NodoValor(1));
        NodoAsignacion incremento = new NodoAsignacion(variable, nodoOperacion);
        generar(incremento);
        UtGen.emitirRM_Abs("LDA", UtGen.PC, localidadSaltoInicio, "for: jmp hacia la prueba");
        localidadActual = UtGen.emitirSalto(0);
        UtGen.cargarRespaldo(localidadSaltoEnd);
        UtGen.emitirRM_Abs("JGT", UtGen.AC, localidadActual, "for: jmp hacia el final");
        UtGen.restaurarRespaldo();
    }

    private static void generarIf(NodoBase nodo) {
        NodoIf n = (NodoIf) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> if");

        // 1. Generar código de la condición
        generar(n.getPrueba());

        // 2. Saltar al ELSE si la condición es falsa (AC == 0)
        int saltoElse = UtGen.emitirSalto(1);
        UtGen.emitirComentario("If: Salto al ELSE si condición es falsa");

        // 3. Generar el THEN
        generar(n.getParteThen());

        // 4. Saltar al final después del THEN
        int saltoFin = UtGen.emitirSalto(1);
        UtGen.emitirComentario("If: Salto al FIN después del THEN");

        // 5. Backpatching para el salto al ELSE
        int labelElse = UtGen.getInstruccionActual();
        UtGen.cargarRespaldo(saltoElse);
        UtGen.emitirRM_Abs("JEQ", UtGen.AC, labelElse, "If: Saltar al ELSE");
        UtGen.restaurarRespaldo();

        // 6. Generar el ELSE (si existe)
        if (n.getParteElse() != null) {
            generar(n.getParteElse());
        }

        // 7. Backpatching para el salto al FIN
        int labelFin = UtGen.getInstruccionActual();
        UtGen.cargarRespaldo(saltoFin);
        UtGen.emitirRM_Abs("LDA", UtGen.PC, labelFin, "If: Saltar al FIN");
        UtGen.restaurarRespaldo();

        if (UtGen.debug) UtGen.emitirComentario("<- if");
    }

    private static void generarRepeat(NodoBase nodo) {
        NodoRepeat n = (NodoRepeat) nodo;
        int localidadSaltoInicio;
        if (UtGen.debug) UtGen.emitirComentario("-> repeat");
        localidadSaltoInicio = UtGen.emitirSalto(0);
        UtGen.emitirComentario("repeat: el salto hacia el final (luego del cuerpo) del repeat debe estar aqui");
        /* Genero el cuerpo del repeat */
        generar(n.getCuerpo());
        /* Genero el codigo de la prueba del repeat */
        generar(n.getPrueba());
        UtGen.emitirRM_Abs("JEQ", UtGen.AC, localidadSaltoInicio, "repeat: jmp hacia el inicio del cuerpo");
        if (UtGen.debug) UtGen.emitirComentario("<- repeat");
    }

    private static void generarAsignacion(NodoBase nodo) {
        if (nodo instanceof NodoAsignacion) {
            NodoAsignacion n = (NodoAsignacion) nodo;
            if (UtGen.debug) UtGen.emitirComentario("-> asignacion");

            generar(n.getExpresion());

            int direccion = tablaSimbolos.getDireccion(n.getIdentificador());
            UtGen.emitirComentario("Asignación normal a variable: " + n.getIdentificador());
            UtGen.emitirRM("ST", UtGen.AC, direccion, UtGen.GP,
                    "asignacion: almaceno el valor para el id " + n.getIdentificador());

            if (UtGen.debug) UtGen.emitirComentario("<- asignacion");
        }
        else if (nodo instanceof NodoAsignacionArray) {
            NodoAsignacionArray n = (NodoAsignacionArray) nodo;
            if (UtGen.debug) UtGen.emitirComentario("-> asignacion a array");
            // Generar el código para la expresión del lado derecho de la asignación
            generar(n.getExpresion());
            // Guardar el valor en la pila temporal
            UtGen.emitirRM("ST", UtGen.AC, desplazamientoTmp--, UtGen.MP, "Guardar valor temporal");
            // Obtener la dirección base del array
            int direccionBase = tablaSimbolos.getDireccion(n.getNombre());
            UtGen.emitirRM("LDC", UtGen.AC1, direccionBase, 0,
                    "Cargar dirección base del array " + n.getNombre());
            // Generar el índice del array
            generar(n.getIndice());
            // Calcular la dirección efectiva sumando el índice a la base del array
            UtGen.emitirRO("ADD", UtGen.AC, UtGen.AC1, UtGen.AC,
                    "Calcular dirección efectiva en el array " + n.getNombre());
            // Recuperar el valor de la pila temporal
            UtGen.emitirRM("LD", UtGen.AC1, ++desplazamientoTmp, UtGen.MP, "Recuperar valor de la pila");
            // Almacenar el valor en la dirección calculada
            UtGen.emitirRM("ST", UtGen.AC1, 0, UtGen.AC,
                    "Guardar valor en el array " + n.getNombre());

            if (UtGen.debug) UtGen.emitirComentario("<- asignacion a array");
        }
        else {
            UtGen.emitirComentario("ERROR: Tipo de asignación no reconocido.");
        }
    }

    private static void generarLeer(NodoBase nodo) {
        NodoLeer n = (NodoLeer) nodo;
        int direccion;
        if (UtGen.debug) UtGen.emitirComentario("-> leer");
        UtGen.emitirRO("IN", UtGen.AC, 0, 0, "leer: lee un valor entero ");
        direccion = tablaSimbolos.getDireccion(n.getIdentificador());
        UtGen.emitirRM("ST", UtGen.AC, direccion, UtGen.GP, "leer: almaceno el valor entero leido en el id " + n.getIdentificador());
        if (UtGen.debug) UtGen.emitirComentario("<- leer");
    }

    private static void generarEscribir(NodoBase nodo) {
        NodoEscribir n = (NodoEscribir) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> escribir");
        /* Genero el codigo de la expresion que va a ser escrita en pantalla */
        generar(n.getExpresion());
        /* Ahora genero la salida */
        UtGen.emitirRO("OUT", UtGen.AC, 0, 0, "escribir: genero la salida de la expresion");
        if (UtGen.debug) UtGen.emitirComentario("<- escribir");
    }

    private static void generarValor(NodoBase nodo) {
        NodoValor n = (NodoValor) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> constante");
        UtGen.emitirRM("LDC", UtGen.AC, n.getValor(), 0, "cargar constante: " + n.getValor());
        if (UtGen.debug) UtGen.emitirComentario("<- constante");
    }

    private static void generarValorBoolean(NodoBase nodo) {
        NodoValorBoolean n = (NodoValorBoolean) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> constante booleana");
        // En este caso convertimos el bool a int para manejar: 1 para true, 0 para false
        int valor = n.getValor() ? 1 : 0;
        UtGen.emitirRM("LDC", UtGen.AC, valor, 0, "cargar constante booleana: " + n.getValor());
        if (UtGen.debug) UtGen.emitirComentario("<- constante booleana");
    }


    private static void generarIdentificador(NodoBase nodo) {
        NodoIdentificador n = (NodoIdentificador) nodo;
        int direccion;
        if (UtGen.debug) UtGen.emitirComentario("-> identificador");
        direccion = tablaSimbolos.getDireccion(n.getNombre());
        UtGen.emitirRM("LD", UtGen.AC, direccion, UtGen.GP, "cargar valor de identificador: " + n.getNombre());
        if (UtGen.debug) UtGen.emitirComentario("-> identificador");
    }

    private static void generarArray(NodoBase nodo) {
        NodoArray n = (NodoArray) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> Declaración de array: " + n.getNombre());

        // Reservamos espacio en memoria
        int direccion = tablaSimbolos.getDireccion(n.getNombre());
        UtGen.emitirComentario("Array " + n.getNombre() + " de tamaño " + n.getSize() + " en " + direccion);

        if (UtGen.debug) UtGen.emitirComentario("<- Declaración de array");
    }


    private static void generarAccesoArray(NodoBase nodo) {
        NodoAccesoArray n = (NodoAccesoArray) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> Acceso a array: " + n.getNombre());

        // Generar código para evaluar el índice
        generar(n.getIndice());

        // Cargar la dirección base del array en AC1
        int direccionBase = tablaSimbolos.getDireccion(n.getNombre());
        UtGen.emitirRM("LDC", UtGen.AC1, direccionBase, 0,
                "Cargar dirección base del array " + n.getNombre());

        // Sumar el índice a la dirección base
        UtGen.emitirRO("ADD", UtGen.AC1, UtGen.AC1, UtGen.AC,
                "Cálculo de dirección del array " + n.getNombre());

        // Cargar el valor almacenado en la dirección calculada
        UtGen.emitirRM("LD", UtGen.AC, 0, UtGen.AC1,
                "Carga del valor del array " + n.getNombre());

        if (UtGen.debug) UtGen.emitirComentario("<- Acceso a array");
    }

    private static void generarOperacion(NodoBase nodo) {
        NodoOperacion n = (NodoOperacion) nodo;
        if (UtGen.debug) UtGen.emitirComentario("-> Operacion: " + n.getOperacion());
        /* Genero la expresion izquierda de la operacion */
        generar(n.getOpIzquierdo());

        if(n.getOpDerecho() != null) {
            /* Almaceno en la pseudo pila de valor temporales el valor de la operacion izquierda */
            UtGen.emitirRM("ST", UtGen.AC, desplazamientoTmp--, UtGen.MP, "op: push en la pila tmp el resultado expresion izquierda");
            /* Genero la expresion derecha de la operacion */
            generar(n.getOpDerecho());
            /* Ahora cargo/saco de la pila el valor izquierdo */
            UtGen.emitirRM("LD", UtGen.AC1, ++desplazamientoTmp, UtGen.MP, "op: pop o cargo de la pila el valor izquierdo en AC1");
        } else {
            /* Si no hay operador derecho, es operacion not*/

            UtGen.emitirRM("JNE", UtGen.AC, 2, UtGen.PC, "");
            UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "");
            UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "");

            UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC, UtGen.AC, "");

        }

        switch (n.getOperacion()) {
            case mas:
                UtGen.emitirRO("ADD", UtGen.AC, UtGen.AC1, UtGen.AC, "op: +");
                break;
            case or:
                UtGen.emitirRO("ADD", UtGen.AC, UtGen.AC1, UtGen.AC, "op: or"); // Sumar valores
                UtGen.emitirRM("JGT", UtGen.AC, 2, UtGen.PC, "Si AC>0, es verdadero");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "Caso falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incondicional");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "Caso verdadero (AC=1)");
                break;
            case menos:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: -");
                break;
            case por:
                UtGen.emitirRO("MUL", UtGen.AC, UtGen.AC1, UtGen.AC, "op: *");
                break;
            case and:
                UtGen.emitirRO("MUL", UtGen.AC, UtGen.AC1, UtGen.AC, "op: and");
                break;
            case entre:
                UtGen.emitirRO("DIV", UtGen.AC, UtGen.AC1, UtGen.AC, "op: /");
                break;
            case modulo:
                UtGen.emitirComentario("Inicio de la operación de módulo");
                UtGen.emitirRM("ST", UtGen.AC1, desplazamientoTmp--, UtGen.MP, "Almacenar valor original de a en la pila temporal");
                UtGen.emitirComentario("Valor original de a almacenado en la pila temporal: " + UtGen.AC);
                UtGen.emitirRO("DIV", UtGen.AC1, UtGen.AC1, UtGen.AC, "División para obtener el cociente");
                UtGen.emitirComentario("Cociente (a / b) en AC: " + UtGen.AC);
                UtGen.emitirRO("MUL", UtGen.AC1, UtGen.AC1, UtGen.AC, "Multiplicar cociente por divisor");
                UtGen.emitirComentario("Resultado de (a / b) * b en AC: " + UtGen.AC);
                UtGen.emitirRM("LD", UtGen.AC, ++desplazamientoTmp, UtGen.MP, "Recuperar valor original de a desde la pila temporal");
                UtGen.emitirComentario("Valor original de a recuperado en AC1: " + UtGen.AC1);
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC, UtGen.AC1, "Restar para obtener el residuo");
                UtGen.emitirComentario("Residuo (a % b) en AC: " + UtGen.AC);
                UtGen.emitirComentario("Fin de la operación de módulo");
                break;
            case menor:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: <");
                UtGen.emitirRM("JLT", UtGen.AC, 2, UtGen.PC, "voy dos instrucciones mas alla if verdadero (AC<0)");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "caso de falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "caso de verdadero (AC=1)");
                break;
            case menorIgual:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: <=");
                UtGen.emitirRM("JLE", UtGen.AC, 2, UtGen.PC, "voy dos instrucciones mas alla if verdadero (AC<=0)");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "caso de falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "caso de verdadero (AC=1)");
                break;
            case mayor:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: >");
                UtGen.emitirRM("JGT", UtGen.AC, 2, UtGen.PC, "voy dos instrucciones mas alla if verdadero (AC>0)");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "caso de falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "caso de verdadero (AC=1)");
                break;
            case mayorIgual:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: >=");
                UtGen.emitirRM("JGE", UtGen.AC, 2, UtGen.PC, "voy dos instrucciones mas alla if verdadero (AC>=0)");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "caso de falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "caso de verdadero (AC=1)");
                break;
            case igual:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: ==");
                UtGen.emitirRM("JEQ", UtGen.AC, 2, UtGen.PC, "voy dos instrucciones mas alla if verdadero (AC==0)");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "caso de falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "caso de verdadero (AC=1)");
                break;
            case noIgual:
                UtGen.emitirRO("SUB", UtGen.AC, UtGen.AC1, UtGen.AC, "op: <>");
                UtGen.emitirRM("JNE", UtGen.AC, 2, UtGen.PC, "voy dos instrucciones mas alla if verdadero (AC<>0)");
                UtGen.emitirRM("LDC", UtGen.AC, 0, UtGen.AC, "caso de falso (AC=0)");
                UtGen.emitirRM("LDA", UtGen.PC, 1, UtGen.PC, "Salto incodicional a direccion: PC+1 (es falso evito colocarlo verdadero)");
                UtGen.emitirRM("LDC", UtGen.AC, 1, UtGen.AC, "caso de verdadero (AC=1)");
                break;
            case not:
                break;
            default:
                UtGen.emitirComentario("BUG: tipo de operacion desconocida");
        }
        if (UtGen.debug) UtGen.emitirComentario("<- Operacion: " + n.getOperacion());
    }

    //TODO: enviar preludio a archivo de salida, obtener antes su nombre
    private static void generarPreludioEstandar() {
        UtGen.emitirComentario("Compilacion TINY para el codigo objeto TM");
        UtGen.emitirComentario("Archivo: " + "NOMBRE_ARREGLAR");
        /*Genero inicializaciones del preludio estandar*/
        /*Todos los registros en tiny comienzan en cero*/
        UtGen.emitirComentario("Preludio estandar:");
        UtGen.emitirRM("LD", UtGen.MP, 0, UtGen.AC, "cargar la maxima direccion desde la localidad 0");
        UtGen.emitirRM("ST", UtGen.AC, 0, UtGen.AC, "limpio el registro de la localidad 0");
    }

}
