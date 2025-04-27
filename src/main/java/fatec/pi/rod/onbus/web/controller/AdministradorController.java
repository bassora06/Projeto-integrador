package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.service.AdministradorService;
import fatec.pi.rod.onbus.web.dto.AdministradorCreateDto;
import fatec.pi.rod.onbus.web.dto.mapper.AdministradorMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/administradores")
public class AdministradorController {

    private final AdministradorService administradorService;

    @PostMapping
    public ResponseEntity<Administrador> criar(@RequestBody AdministradorCreateDto dto) {
        Administrador administrador = AdministradorMapper.toEntity(dto);
        return ResponseEntity.ok(administradorService.salvar(administrador));
    }
}