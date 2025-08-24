package fatec.pi.rod.onbus.web.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdministradorResponseDto {
    private Long id;
    private String nome;
    private String email;
}