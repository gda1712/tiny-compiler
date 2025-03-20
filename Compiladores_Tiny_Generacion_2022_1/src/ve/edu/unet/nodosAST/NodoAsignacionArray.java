package ve.edu.unet.nodosAST;

public class NodoAsignacionArray extends NodoBase {
    private String nombre;
    private NodoBase indice;
    private NodoBase expresion;

    public NodoAsignacionArray(String nombre, NodoBase indice, NodoBase expresion) {
        super();
        this.nombre = nombre;
        this.indice = indice;
        this.expresion = expresion;
    }

    public String getNombre() {
        return nombre;
    }

    public NodoBase getIndice() {
        return indice;
    }

    public NodoBase getExpresion() {
        return expresion;
    }
}
