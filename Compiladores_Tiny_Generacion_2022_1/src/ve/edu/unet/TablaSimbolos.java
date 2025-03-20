package ve.edu.unet;

import ve.edu.unet.nodosAST.*;

import java.util.*;




public class TablaSimbolos {
	private HashMap<String, RegistroSimbolo> tabla;
	private int direccion;  //Contador de las localidades de memoria asignadas a la tabla
	
	public TablaSimbolos() {
		super();
		tabla = new HashMap<String, RegistroSimbolo>();
		direccion=0;
	}

	public void cargarTabla(NodoBase raiz){
		while (raiz != null) {
	    if (raiz instanceof NodoIdentificador) {
	    	InsertarSimbolo(((NodoIdentificador)raiz).getNombre(),-1);
	    }

		// Fue necesario agregar a la tabla de sinbolos el identiicados para los nodos de asignacion
		// para tener la referencia del simbolo
		if(raiz instanceof NodoAsignacion){
			InsertarSimbolo(((NodoAsignacion)raiz).getIdentificador(),-1);
		}

	    /* Hago el recorrido recursivo */
	    if (raiz instanceof  NodoIf){
	    	cargarTabla(((NodoIf)raiz).getPrueba());
	    	cargarTabla(((NodoIf)raiz).getParteThen());
	    	if(((NodoIf)raiz).getParteElse()!=null){
	    		cargarTabla(((NodoIf)raiz).getParteElse());
	    	}
	    }
	    else if (raiz instanceof  NodoRepeat){
	    	cargarTabla(((NodoRepeat)raiz).getCuerpo());
	    	cargarTabla(((NodoRepeat)raiz).getPrueba());
	    }
	    else if (raiz instanceof  NodoAsignacion)
	    	cargarTabla(((NodoAsignacion)raiz).getExpresion());
	    else if (raiz instanceof  NodoEscribir)
	    	cargarTabla(((NodoEscribir)raiz).getExpresion());
	    else if (raiz instanceof NodoOperacion){
	    	cargarTabla(((NodoOperacion)raiz).getOpIzquierdo());
	    	cargarTabla(((NodoOperacion)raiz).getOpDerecho());
	    }
		else if (raiz instanceof NodoFor) {
			cargarTabla(((NodoFor)raiz).getAsignacion());
			cargarTabla(((NodoFor)raiz).getExpresion());
			cargarTabla(((NodoFor)raiz).getCuerpo());
		}
		else if (raiz instanceof NodoArray) {
			NodoArray nodoArray = (NodoArray) raiz;
			InsertarSimbolo(nodoArray.getNombre(), -1);
		}
	    raiz = raiz.getHermanoDerecha();
	  }
	}
	
	//true es nuevo no existe se insertara, false ya existe NO se vuelve a insertar 
	public boolean InsertarSimbolo(String identificador, int numLinea){
		RegistroSimbolo simbolo;
		if(tabla.containsKey(identificador)){
			return false;
		}else{
			simbolo= new RegistroSimbolo(identificador,numLinea,direccion++);
			tabla.put(identificador,simbolo);
			return true;			
		}
	}
	
	public RegistroSimbolo BuscarSimbolo(String identificador){
		RegistroSimbolo simbolo=(RegistroSimbolo)tabla.get(identificador);
		return simbolo;
	}
	
	public void ImprimirClaves(){
		System.out.println("*** Tabla de Simbolos ***");
		for( Iterator <String>it = tabla.keySet().iterator(); it.hasNext();) { 
            String s = (String)it.next();
	    System.out.println("Consegui Key: "+s+" con direccion: " + BuscarSimbolo(s).getDireccionMemoria());
		}
	}

	public int getDireccion(String Clave) {
		RegistroSimbolo registro = BuscarSimbolo(Clave);
		if (registro == null) {
			throw new RuntimeException("Variable '" + Clave + "' no existe en la tabla de símbolos.");
		}
		return registro.getDireccionMemoria();
	}

	public boolean InsertarSimboloArray(String identificador, int tamaño, int numLinea) {
		if(tabla.containsKey(identificador)){
			return false;
		} else {
			RegistroSimbolo simbolo = new RegistroSimbolo(identificador, numLinea, direccion);
			tabla.put(identificador, simbolo);
			direccion += tamaño;  // Reservamos espacio en memoria para el array
			return true;
		}
	}
	
	/*
	 * TODO:
	 * 1. Crear lista con las lineas de codigo donde la variable es usada.
	 * */
}
