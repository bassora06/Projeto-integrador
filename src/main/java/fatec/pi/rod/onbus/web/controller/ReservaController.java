package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Onibus;
import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.entity.Reserva;
import fatec.pi.rod.onbus.service.OnibusService;
import fatec.pi.rod.onbus.service.ReservaService;
import fatec.pi.rod.onbus.service.UsuarioService;
import fatec.pi.rod.onbus.web.dto.ReservaCreateDto;
import fatec.pi.rod.onbus.web.dto.ReservaResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@RestController
@RequestMapping("/reservas")
public class ReservaController {

    private final ReservaService reservaService;
    private final OnibusService onibusService;
    private final UsuarioService usuarioService;

    @PostMapping
    public ResponseEntity<ReservaResponseDto> criarReserva(@RequestBody ReservaCreateDto createDto) {
        Reserva reserva = new Reserva();

        // Buscar o objeto Onibus pelo ID
        Onibus onibus = onibusService.buscarPorId(createDto.getIdOnibus());
        reserva.setOnibus(onibus);

        // Buscar o objeto Usuario pelo ID
        Usuario usuario = usuarioService.buscarPorId(createDto.getIdUsuario());
        reserva.setUsuario(usuario);

        reserva.setHora_chegada(createDto.getHoraChegada());
        reserva.setHora_saida(createDto.getHoraSaida());
        reserva.setDoca(createDto.getDoca());
        reserva.setVaga(createDto.getVaga());

        Reserva salva = reservaService.salvar(reserva);
        ReservaResponseDto responseDto = new ReservaResponseDto(
                salva.getId_reserva(),
                salva.getOnibus().getId(),
                salva.getUsuario().getId(),
                salva.getHora_chegada(),
                salva.getHora_saida(),
                salva.getDoca(),
                salva.getVaga()
        );

        return ResponseEntity.ok(responseDto);
    }

    @GetMapping
    public ResponseEntity<List<ReservaResponseDto>> listarReservas() {
        List<Reserva> reservas = reservaService.buscarTodas();
        List<ReservaResponseDto> responseDtos = reservas.stream().map(reserva -> new ReservaResponseDto(
                reserva.getId_reserva(),
                reserva.getOnibus().getId(),
                reserva.getUsuario().getId(),
                reserva.getHora_chegada(),
                reserva.getHora_saida(),
                reserva.getDoca(),
                reserva.getVaga()
        )).collect(Collectors.toList());

        return ResponseEntity.ok(responseDtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservaResponseDto> buscarReserva(@PathVariable Integer id) {
        Reserva reserva = reservaService.buscarPorId(id);
        ReservaResponseDto responseDto = new ReservaResponseDto(
                reserva.getId_reserva(),
                reserva.getOnibus().getId(),
                reserva.getUsuario().getId(),
                reserva.getHora_chegada(),
                reserva.getHora_saida(),
                reserva.getDoca(),
                reserva.getVaga()
        );

        return ResponseEntity.ok(responseDto);
    }
}