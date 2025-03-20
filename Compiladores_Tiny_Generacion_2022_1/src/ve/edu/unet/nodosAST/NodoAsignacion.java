package ve.edu.unet.nodosAST;

public class NodoAsignacion extends NodoBase {
	private String identificador;
	private NodoAccesoArray accesoArray;
	private NodoBase expresion;

	// Constructor para asignación a variables normales
	public NodoAsignacion(String identificador, NodoBase expresion) {
		super();
		this.identificador = identificador;
		this.expresion = expresion;
		this.accesoArray = null;
	}

	// Constructor para asignación a Arrays
	public NodoAsignacion(NodoAccesoArray accesoArray, NodoBase expresion) {
		super();
		this.accesoArray = accesoArray;
		this.expresion = expresion;
		this.identificador = null;
	}

	public String getIdentificador() {
		return identificador;
	}

	public NodoAccesoArray getAccesoArray() {
		return accesoArray;
	}

	public NodoBase getExpresion() {
		return expresion;
	}
}
