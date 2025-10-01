package fatec.pi.rod.onbus.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.DiscriminatorValue;

@Entity
@DiscriminatorValue("ROLE_EMPRESA")
public class Empresa extends Usuario {

    @Column(name = "cnpj", length = 14, nullable = true)
    private String cnpj;

    public Empresa() {}

    public Empresa(String nome, String email, String senha, Boolean ativo, String cnpj) {
        super(nome, email, senha, ativo);
        this.cnpj = cnpj;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }
}