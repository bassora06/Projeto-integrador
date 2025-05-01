package fatec.pi.rod.onbus.web.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OnibusResponseDto {

    private Long id;
    private String placa;
    private Long usuarioId;
}