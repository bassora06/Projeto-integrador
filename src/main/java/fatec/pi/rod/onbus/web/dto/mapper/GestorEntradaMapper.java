package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.web.dto.GestorEntradaCreateDto;
import fatec.pi.rod.onbus.web.dto.GestorEntradaResponseDto;

import java.util.List;
import java.util.stream.Collectors;

public class GestorEntradaMapper {

    public static GestorEntrada toEntity(GestorEntradaCreateDto dto) {
        GestorEntrada gestorEntrada = new GestorEntrada();
        gestorEntrada.setNome(dto.getNome());
        gestorEntrada.setEmail(dto.getEmail());
        gestorEntrada.setSenha(dto.getSenha());
        return gestorEntrada;
    }

    public static GestorEntradaResponseDto toDto(GestorEntrada gestor) {
        return new GestorEntradaResponseDto(gestor.getId(), gestor.getNome(), gestor.getEmail());
    }

    public static List<GestorEntradaResponseDto> toListDto(List<GestorEntrada> gestores) {
        return gestores.stream().map(GestorEntradaMapper::toDto).collect(Collectors.toList());
    }
}