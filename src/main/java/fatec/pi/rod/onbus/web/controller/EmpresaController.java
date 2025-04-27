package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.service.EmpresaService;
import fatec.pi.rod.onbus.web.dto.EmpresaCreateDto;
import fatec.pi.rod.onbus.web.dto.mapper.EmpresaMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/empresas")
public class EmpresaController {

    private final EmpresaService empresaService;

    @PostMapping
    public ResponseEntity<Empresa> criar(@RequestBody EmpresaCreateDto dto) {
        Empresa empresa = EmpresaMapper.toEntity(dto);
        return ResponseEntity.ok(empresaService.salvar(empresa));
    }
}