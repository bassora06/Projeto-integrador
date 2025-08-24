package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.service.GestorEntradaService;
import fatec.pi.rod.onbus.web.dto.GestorEntradaCreateDto;
import fatec.pi.rod.onbus.web.dto.GestorEntradaResponseDto;
import fatec.pi.rod.onbus.web.dto.mapper.GestorEntradaMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/gestores-entrada")
public class GestorEntradaController {

    private final GestorEntradaService gestorEntradaService;

    @PostMapping
    public ResponseEntity<GestorEntrada> criar(@RequestBody GestorEntradaCreateDto dto) {
        GestorEntrada gestorEntrada = GestorEntradaMapper.toEntity(dto);
        return ResponseEntity.ok(gestorEntradaService.salvar(gestorEntrada));
    }

    @GetMapping
    public ResponseEntity<List<GestorEntradaResponseDto>> getAll() {
        List<GestorEntrada> gestores = gestorEntradaService.buscarTodos();
        return ResponseEntity.ok(GestorEntradaMapper.toListDto(gestores));
    }

    @GetMapping("/{id}")
    public ResponseEntity<GestorEntradaResponseDto> getById(@PathVariable Long id) {
        GestorEntrada gestor = gestorEntradaService.buscarPorId(id);
        return ResponseEntity.ok(GestorEntradaMapper.toDto(gestor));
    }
}