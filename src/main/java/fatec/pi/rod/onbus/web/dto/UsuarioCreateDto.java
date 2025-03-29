package fatec.pi.rod.onbus.web.dto;

import fatec.pi.rod.onbus.entity.Usuario;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UsuarioCreateDto {
    private String nome;
    private String email;
    private String senha;
    private Usuario.Role tipo;
}

