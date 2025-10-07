package fatec.pi.rod.onbus.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.DiscriminatorValue;

@Entity
@DiscriminatorValue("ROLE_GESTORENTRADA")
public class GestorEntrada extends Usuario {

    public GestorEntrada() {}

    public GestorEntrada(String nome, String email, String senha, Boolean ativo) {
        super(nome, email, senha, ativo);
    }
}