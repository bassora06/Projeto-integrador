package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.web.dto.AdministradorCreateDto;

public class AdministradorMapper {

    public static Administrador toEntity(AdministradorCreateDto dto) {
        return new Administrador(dto.getNome(), dto.getEmail(), dto.getSenha(), true);
    }
}