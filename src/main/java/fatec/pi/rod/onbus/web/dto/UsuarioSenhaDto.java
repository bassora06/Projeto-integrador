package fatec.pi.rod.onbus.web.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UsuarioSenhaDto {

    @NotBlank
    private String senhaAtual;

    @NotBlank
    @Size(min = 8, max = 8, message = "A senha deve ter 8 caracteres")
    private String novaSenha;

    @NotBlank
    @Size(min = 8, max = 8, message = "A senha deve ter 8 caracteres")
    private String confirmaSenha;
}
