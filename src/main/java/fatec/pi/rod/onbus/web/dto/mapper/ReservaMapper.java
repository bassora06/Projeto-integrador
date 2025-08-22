package fatec.pi.rod.onbus.web.dto.mapper;

import fatec.pi.rod.onbus.entity.Reserva;
import fatec.pi.rod.onbus.web.dto.ReservaCreateDto;
import fatec.pi.rod.onbus.web.dto.ReservaResponseDto;

import java.util.List;
import java.util.stream.Collectors;

public class ReservaMapper {

    public static Reserva toEntity(ReservaCreateDto dto) {
        Reserva reserva = new Reserva();
        reserva.setIdOnibus(dto.getIdOnibus());
        reserva.setIdUsuario(dto.getIdUsuario());
        reserva.setHoraChegada(dto.getHoraChegada());
        reserva.setHoraSaida(dto.getHoraSaida());
        reserva.setDoca(dto.getDoca());
        reserva.setVaga(dto.getVaga());
        return reserva;
    }

    public static ReservaResponseDto toDto(Reserva reserva) {
        return new ReservaResponseDto(
                reserva.getIdReserva(),
                reserva.getIdOnibus(),
                reserva.getIdUsuario(),
                reserva.getHoraChegada(),
                reserva.getHoraSaida(),
                reserva.getDoca(),
                reserva.getVaga()
        );
    }

    public static List<ReservaResponseDto> toListDto(List<Reserva> reservas) {
        return reservas.stream().map(ReservaMapper::toDto).collect(Collectors.toList());
    }
}