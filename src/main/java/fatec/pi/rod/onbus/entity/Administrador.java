package fatec.pi.rod.onbus.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.io.Serializable;
import java.time.LocalDateTime;

//@Entity
//@Table(name = "usuario")

@Entity
@DiscriminatorValue("ROLE_ADMIN")
public class Administrador extends Usuario {

    public Administrador(){}

    public Administrador(String nome, String email, String senha, Boolean ativo) {
        super(nome, email, senha, ativo);
    }
}
