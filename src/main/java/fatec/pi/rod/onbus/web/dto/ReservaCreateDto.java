package fatec.pi.rod.onbus.web.dto;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReservaCreateDto {

    @NotNull
    private Long idOnibus;

    @NotNull
    private Long idUsuario;

    @NotNull
    private LocalDateTime horaChegada;

    @NotNull
    private LocalDateTime horaSaida;

    @NotNull
    private char doca;

    @NotNull
    private char vaga;
}