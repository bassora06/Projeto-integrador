package fatec.pi.rod.onbus.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.io.Serializable;
import java.time.LocalDateTime;


@Entity
@DiscriminatorValue("ROLE_EMPRESA")
public class Empresa extends Usuario {

    @Column(name = "cnpj", length = 14, nullable = false)
    private String cnpj;

    public Empresa(){}

    public Empresa(String nome, String email, String senha, Boolean ativo, String cnpj) {
        super(nome, email, senha, ativo);
        this.cnpj = cnpj;
    }

    public void setCnpj(String cnpj){ this.cnpj = cnpj; }

    public String getCnpj(){ return cnpj; }

}
