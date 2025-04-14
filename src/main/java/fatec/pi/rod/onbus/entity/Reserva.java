package fatec.pi.rod.onbus.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "reserva")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id_reserva;

    @ManyToOne
    @JoinColumn(name = "id_onibus", nullable = false)
    private Onibus onibus;

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    private LocalDateTime hora_chegada;
    private LocalDateTime hora_saida;

    private char doca;
    private char vaga;

    private LocalDateTime created_at;
    private LocalDateTime updated_at;

    // Essas anotações abaixo são para atualizar as datas automaticamente (datas de criação e de atualização)

    @PrePersist
    protected void onCreate() {
        created_at = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updated_at = LocalDateTime.now();
    }
}

