package ve.edu.unet.nodosAST;

public class NodoComentario extends NodoBase {
    private String comentario;

    public NodoComentario(String comentario) {
        this.comentario = comentario;
    }

    public String getComentario() {
        return comentario;
    }
}