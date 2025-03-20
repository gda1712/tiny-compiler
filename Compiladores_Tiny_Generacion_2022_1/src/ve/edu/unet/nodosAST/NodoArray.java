package ve.edu.unet.nodosAST;

public class NodoArray extends NodoBase {
    private String nombre;
    private int tamaño;

    public NodoArray(String nombre, int tamaño) {
        this.nombre = nombre;
        this.tamaño = tamaño;
    }

    public String getNombre() {
        return nombre;
    }

    public int getSize() {
        return tamaño;
    }
}
