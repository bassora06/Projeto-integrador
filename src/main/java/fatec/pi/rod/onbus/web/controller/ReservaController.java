package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Reserva;
import fatec.pi.rod.onbus.service.ReservaService;
import fatec.pi.rod.onbus.web.dto.ReservaCreateDto;
import fatec.pi.rod.onbus.web.dto.ReservaResponseDto;
import fatec.pi.rod.onbus.web.dto.mapper.ReservaMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping({"/reservas", "/api/reservas"})
public class ReservaController {

    private final ReservaService reservaService;

    @PostMapping
    // Permitir sem segurança para dev; @PreAuthorize pode ser reativado depois
    public ResponseEntity<ReservaResponseDto> criar(@RequestBody ReservaCreateDto dto) {
        Reserva reserva = ReservaMapper.toEntity(dto);
        Reserva savedReserva = reservaService.salvar(reserva);
        return ResponseEntity.ok(ReservaMapper.toDto(savedReserva));
    }

    @GetMapping
    public ResponseEntity<List<ReservaResponseDto>> getAll() {
        List<Reserva> reservas = reservaService.buscarTodas();
        return ResponseEntity.ok(ReservaMapper.toListDto(reservas));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservaResponseDto> getById(@PathVariable Integer id) {
        Reserva reserva = reservaService.buscarPorId(id);
        return ResponseEntity.ok(ReservaMapper.toDto(reserva));
    }
}
