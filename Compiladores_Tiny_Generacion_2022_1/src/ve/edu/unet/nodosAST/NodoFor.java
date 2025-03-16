package ve.edu.unet.nodosAST;

public class NodoFor extends NodoBase{
    private NodoBase asignacion;
    private NodoBase expresion;
    private NodoBase cuerpo;

    public NodoFor(NodoBase asignacion, NodoBase expresion, NodoBase cuerpo) {
        super();
        this.asignacion = asignacion;
        this.expresion = expresion;
        this.cuerpo = cuerpo;
    }

    public NodoFor() {
        super();
        this.asignacion = null;
        this.expresion = null;
        this.cuerpo = null;
    }

    public NodoBase getAsignacion() {
        return asignacion;
    }

    public NodoBase getExpresion() {
        return expresion;
    }

    public NodoBase getCuerpo() {
        return cuerpo;
    }

    public void setAsignacion(NodoBase asignacion) {
        this.asignacion = asignacion;
    }

    public void setExpresion(NodoBase expresion) {
        this.expresion = expresion;
    }

    public void setCuerpo(NodoBase cuerpo) {
        this.cuerpo = cuerpo;
    }
}