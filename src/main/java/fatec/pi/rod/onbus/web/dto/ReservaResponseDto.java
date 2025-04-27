package fatec.pi.rod.onbus.web.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReservaResponseDto {

    private Integer idReserva;
    private Long idOnibus;
    private Long idUsuario;
    private LocalDateTime horaChegada;
    private LocalDateTime horaSaida;
    private char doca;
    private char vaga;
}