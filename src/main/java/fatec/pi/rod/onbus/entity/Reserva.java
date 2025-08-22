package fatec.pi.rod.onbus.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "reserva")
public class Reserva {

    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    private Integer idReserva;

    @Column(name = "id_onibus", nullable = false)
    private Long idOnibus;

    @Column(name = "id_usuario", nullable = false)
    private Long idUsuario;

    @Column(name = "horario_chegada", nullable = false)
    private LocalDateTime horaChegada;

    @Column(name = "horario_saida", nullable = false)
    private LocalDateTime horaSaida;

    @Column(name = "doca", nullable = false)
    private char doca;

    @Column(name = "vaga", nullable = false)
    private char vaga;
}