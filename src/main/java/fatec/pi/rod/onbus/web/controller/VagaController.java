package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.StatusVaga;
import fatec.pi.rod.onbus.entity.Topicos;
import fatec.pi.rod.onbus.entity.VagaDocument;
import fatec.pi.rod.onbus.entity.VagaService;
import fatec.pi.rod.onbus.web.dto.VagaResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/vagas")
public class VagaController {

    private final VagaService vagaService;

    public VagaController(VagaService vagaService) {
        this.vagaService = vagaService;
    }

    /**
     * Endpoint para buscar o status de todas as vagas.
     * @return Lista com o status de cada vaga no formato JSON desejado.
     */
    @GetMapping
    public ResponseEntity<List<VagaResponseDto>> getStatusDeTodasAsVagas() {
        // Usa a lista de tópicos para buscar o status de cada vaga
        List<VagaResponseDto> listaDeVagas = Topicos.TODOS.stream()
                .map(this::converterParaDto) // Converte cada vaga para o formato de resposta
                .collect(Collectors.toList());
        return ResponseEntity.ok(listaDeVagas);
    }

    /**
     * Endpoint para buscar o status de uma vaga específica.
     * @param nomeVaga O nome do tópico da vaga (ex: "vaga1").
     * @return O status da vaga no formato JSON desejado.
     */

    @GetMapping("/{nomeVaga}")
    public ResponseEntity<VagaResponseDto> getStatusDaVaga(@PathVariable String nomeVaga) {
        VagaResponseDto vagaDto = converterParaDto(nomeVaga);
        return ResponseEntity.ok(vagaDto);
    }

    /**
     * Método auxiliar para converter o status interno da vaga para o DTO de resposta.
     */
    private VagaResponseDto converterParaDto(String nomeDaVaga) {
        // O serviço agora retorna o documento completo do MongoDB
        VagaDocument vagaDoc = vagaService.getStatusVaga(nomeDaVaga);

        String statusFinal = vagaDoc.getStatus() == StatusVaga.LIVRE ? "livre" : "ocupada";
        boolean excedidaFinal = vagaDoc.isExcedida();

        return new VagaResponseDto(nomeDaVaga, statusFinal, excedidaFinal);
    }
}