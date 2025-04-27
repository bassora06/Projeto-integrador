package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.web.dto.GestorEntradaCreateDto;

public class GestorEntradaMapper {

    public static GestorEntrada toEntity(GestorEntradaCreateDto dto) {
        return new GestorEntrada(dto.getNome(), dto.getEmail(), dto.getSenha(), true);
    }
}