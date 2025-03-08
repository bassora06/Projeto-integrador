package fatec.pi.rod.onbus.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "Usuario")
public class Usuario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Long id;

    @Column(name = "nome", nullable = false, length = 225)
    private String nome;

    @Column(name = "email", nullable = false, length = 225, unique = true)
    private String email;

    @Column(name = "senha", nullable = false, length = 225)
    private String senha;

    @Column(name = "ativo", nullable = false)
    private Boolean ativo = true;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo", nullable = false)
    private Role tipo;

    @Column(name = "cnpj", length = 14)
    private String cnpj;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public enum Role {
        ADMIN,
        EMPRESA,
        GESTOREMPRESA
    }
}
