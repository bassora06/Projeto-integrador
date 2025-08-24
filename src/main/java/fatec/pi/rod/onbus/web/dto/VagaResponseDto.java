package fatec.pi.rod.onbus.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class VagaResponseDto {

    private String vaga;
    private String status;
    private boolean excedida;
}