package fatec.pi.rod.onbus.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@DiscriminatorValue("ROLE_GESTORENTRADA")
public class GestorEntrada extends Usuario implements Serializable {


    public GestorEntrada(){}

    public GestorEntrada(String nome, String email, String senha, Boolean ativo) {
        super(nome, email, senha, ativo);
    }

}
