package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.web.dto.EmpresaCreateDto;
import fatec.pi.rod.onbus.web.dto.EmpresaResponseDto;

import java.util.List;
import java.util.stream.Collectors;

public class EmpresaMapper {

    public static EmpresaResponseDto toDto(Empresa empresa) {
        return new EmpresaResponseDto(empresa.getId(), empresa.getNome(), empresa.getEmail(), empresa.getCnpj());
    }

    public static List<EmpresaResponseDto> toListDto(List<Empresa> empresas) {
        return empresas.stream().map(EmpresaMapper::toDto).collect(Collectors.toList());
    }

    public static Empresa toEntity(EmpresaCreateDto dto) {
        return new Empresa(dto.getNome(), dto.getEmail(), dto.getSenha(), true, dto.getCnpj());
    }
}