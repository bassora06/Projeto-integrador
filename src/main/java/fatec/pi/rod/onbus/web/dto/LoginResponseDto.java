package fatec.pi.rod.onbus.web.dto;

import fatec.pi.rod.onbus.entity.Usuario;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoginResponseDto {
    
    private String userType;
    private Long userId;
    private String nome;
    private String email;
    private String sessionId;
    private Integer sessionTimeout;

    public static LoginResponseDto fromUser(Usuario user, String sessionId, Integer sessionTimeout) {
        return new LoginResponseDto(
            user.getTipo().toString(),
            user.getId(),
            user.getNome(),
            user.getEmail(),
            sessionId,
            sessionTimeout
        );
    }
}