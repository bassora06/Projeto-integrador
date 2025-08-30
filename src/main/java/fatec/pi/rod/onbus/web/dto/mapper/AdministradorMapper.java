package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.web.dto.AdministradorCreateDto;
import fatec.pi.rod.onbus.web.dto.AdministradorResponseDto;

import java.util.List;
import java.util.stream.Collectors;

public class AdministradorMapper {

    public static AdministradorResponseDto toDto(Administrador administrador) {
        return new AdministradorResponseDto(administrador.getId(), administrador.getNome(), administrador.getEmail());
    }

    public static List<AdministradorResponseDto> toListDto(List<Administrador> administradores) {
        return administradores.stream().map(AdministradorMapper::toDto).collect(Collectors.toList());
    }

    public static Administrador toEntity(AdministradorCreateDto dto) {
        Administrador administrador = new Administrador();
        administrador.setNome(dto.getNome());
        administrador.setEmail(dto.getEmail());
        administrador.setSenha(dto.getSenha());
        administrador.setAtivo(true);
        administrador.setTipo(Usuario.Role.ROLE_ADMIN);
        return administrador;
    }
}