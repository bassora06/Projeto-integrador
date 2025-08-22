package fatec.pi.rod.onbus.web.dto;

import fatec.pi.rod.onbus.entity.Usuario;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UsuarioCreateDto {

    @NotBlank
    private String nome;
    @NotBlank
    @Email(message = "Email inválido", regexp = "^[a-z0-9.+-]+@[a-z0-9.-]+\\.[a-z]{2,}$")
    private String email;
    @NotBlank
    @Size(min = 8, max = 8, message = "A senha deve ter 8 caracteres")
    private String senha;
    private Usuario.Role tipo;
}

