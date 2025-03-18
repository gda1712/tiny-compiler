package ve.edu.unet.nodosAST;

public class NodoValorBoolean  extends NodoBase {
    private Boolean valor;

    public NodoValorBoolean(Boolean valor) {
        super();
        this.valor = valor;
    }

    public NodoValorBoolean(){
        super();
    }

    public Boolean getValor() {
        return valor;
    }
}
