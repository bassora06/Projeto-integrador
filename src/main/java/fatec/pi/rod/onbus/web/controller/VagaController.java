package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.StatusVaga;
import fatec.pi.rod.onbus.entity.Topicos;
import fatec.pi.rod.onbus.entity.VagaDocument;
import fatec.pi.rod.onbus.entity.VagaService;
import fatec.pi.rod.onbus.web.dto.VagaResponseDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping({"/api/v1/vagas", "/api/vagas"})
public class VagaController {

    private final VagaService vagaService;

    public VagaController(VagaService vagaService) {
        this.vagaService = vagaService;
    }

    @GetMapping
    public ResponseEntity<List<VagaResponseDto>> getStatusDeTodasAsVagas() {
        List<VagaResponseDto> listaDeVagas = Topicos.TODOS.stream()
                .map(this::converterParaDto)
                .collect(Collectors.toList());
        return ResponseEntity.ok(listaDeVagas);
    }

    @GetMapping("/{nomeVaga}")
    public ResponseEntity<VagaResponseDto> getStatusDaVaga(@PathVariable String nomeVaga) {
        VagaResponseDto vagaDto = converterParaDto(nomeVaga);
        return ResponseEntity.ok(vagaDto);
    }

    private VagaResponseDto converterParaDto(String nomeDaVaga) {
        VagaDocument vagaDoc = vagaService.getStatusVaga(nomeDaVaga);

        String statusFinal = vagaDoc.getStatus() == StatusVaga.LIVRE ? "livre" : "ocupada";
        boolean excedidaFinal = vagaDoc.isExcedida();

        return new VagaResponseDto(nomeDaVaga, statusFinal, excedidaFinal);
    }
}
