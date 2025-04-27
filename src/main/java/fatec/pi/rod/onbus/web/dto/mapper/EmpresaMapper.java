package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.web.dto.EmpresaCreateDto;

public class EmpresaMapper {

    public static Empresa toEntity(EmpresaCreateDto dto) {
        return new Empresa(dto.getNome(), dto.getEmail(), dto.getSenha(), true, dto.getCnpj());
    }
}