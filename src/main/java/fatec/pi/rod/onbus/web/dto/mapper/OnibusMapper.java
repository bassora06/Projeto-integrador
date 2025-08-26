package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.Onibus;
import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.web.dto.OnibusCreateDto;
import fatec.pi.rod.onbus.web.dto.OnibusResponseDto;

public class OnibusMapper {

    public static Onibus toEntity(OnibusCreateDto dto, Usuario usuario) {
        Onibus onibus = new Onibus();
        onibus.setPlaca(dto.getPlaca());
        onibus.setUsuario(usuario);
        return onibus;
    }

    public static OnibusResponseDto toDto(Onibus onibus) {
        return new OnibusResponseDto(
                onibus.getId(),
                onibus.getPlaca(),
                onibus.getUsuario().getId()
        );
    }
}