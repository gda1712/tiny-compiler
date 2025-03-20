package ve.edu.unet.nodosAST;

public class NodoAccesoArray extends NodoBase {
    private String nombre;
    private NodoBase indice;

    public NodoAccesoArray(String nombre, NodoBase indice) {
        this.nombre = nombre;
        this.indice = indice;
    }

    public String getNombre() {
        return nombre;
    }

    public NodoBase getIndice() {
        return indice;
    }
}
