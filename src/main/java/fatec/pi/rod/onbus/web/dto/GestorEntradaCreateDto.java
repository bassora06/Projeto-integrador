package fatec.pi.rod.onbus.web.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class GestorEntradaCreateDto {

    @NotBlank
    private String nome;

    @NotBlank
    private String email;

    @NotBlank
    private String senha;
}