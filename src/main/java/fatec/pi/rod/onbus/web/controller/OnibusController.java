package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Onibus;
import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.service.OnibusService;
import fatec.pi.rod.onbus.service.UsuarioService;
import fatec.pi.rod.onbus.web.dto.OnibusCreateDto;
import fatec.pi.rod.onbus.web.dto.OnibusResponseDto;
import fatec.pi.rod.onbus.web.dto.mapper.OnibusMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/v1/onibus")
public class OnibusController {

    private final OnibusService onibusService;
    private final UsuarioService usuarioService;

    @PostMapping
    public ResponseEntity<OnibusResponseDto> create(@RequestBody OnibusCreateDto dto) {
        Usuario usuario = usuarioService.buscarPorId(dto.getUsuarioId());
        Onibus onibus = OnibusMapper.toEntity(dto, usuario);
        Onibus savedOnibus = onibusService.salvar(onibus);
        return ResponseEntity.status(HttpStatus.CREATED).body(OnibusMapper.toDto(savedOnibus));
    }

    @GetMapping
    public ResponseEntity<List<OnibusResponseDto>> getAll() {
        List<Onibus> onibusList = onibusService.buscarTodos();
        List<OnibusResponseDto> response = onibusList.stream()
                .map(OnibusMapper::toDto)
                .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OnibusResponseDto> getById(@PathVariable Long id) {
        Onibus onibus = onibusService.buscarPorId(id);
        return ResponseEntity.ok(OnibusMapper.toDto(onibus));
    }
}