package fatec.pi.rod.onbus.web.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OnibusCreateDto {

    @NotBlank
    private String placa;

    @NotNull
    private Long usuarioId;
}