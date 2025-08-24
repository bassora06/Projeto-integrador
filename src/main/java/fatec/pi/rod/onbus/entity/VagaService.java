package fatec.pi.rod.onbus.entity;

import fatec.pi.rod.onbus.repository.VagaRepository; // IMPORTAR
import lombok.RequiredArgsConstructor; // ADICIONAR
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.time.Duration;
import java.time.Instant;
import java.util.List; // IMPORTAR

@Component
@RequiredArgsConstructor // ADICIONAR
public class VagaService {

    private final Log log = new Log();
    private final MqttService mqttService;
    private final VagaRepository vagaRepository; // INJEÇÃO DE DEPENDÊNCIA
    private static final Duration LIMITE = Duration.ofMinutes(1);

    @Scheduled(fixedRate = 60_000)
    public void verificarExpiracoes() {
        log.logInfo("🔍 Verificando expiração de vagas no MongoDB...");

        // Calcula o ponto no tempo para considerar uma vaga expirada
        Instant tempoLimite = Instant.now().minus(LIMITE);

        // Busca no banco todas as vagas que estão OCUPADAS, não foram marcadas como EXCEDIDAS
        // e cujo tempo de início de ocupação é anterior ao tempoLimite calculado.
        List<VagaDocument> vagasParaExpirar = vagaRepository
                .findByStatusAndExcedidaAndInicioOcupacaoBefore(StatusVaga.OCUPADA, false, tempoLimite);

        for (VagaDocument vaga : vagasParaExpirar) {
            vaga.setExcedida(true); // Marca como excedida
            vaga.setStatus(StatusVaga.EXPIRADA); // Atualiza o status
            vagaRepository.save(vaga); // Salva no banco

            mqttService.publicarTimeout(vaga.getId()); // Notifica via MQTT
            log.logAtencao("⚠️ Vaga '%s' EXPIRADA e atualizada no banco.".formatted(vaga.getId()));
        }

        if (vagasParaExpirar.isEmpty()) {
            log.logInfo("✅ Nenhuma vaga excedeu o tempo limite.");
        }
        System.out.println(" ");
    }

    public VagaDocument getStatusVaga(String topico) {
        // Busca a vaga diretamente do MongoDB. Se não encontrar, retorna um estado LIVRE padrão.
        return vagaRepository.findById(topico)
                .orElse(new VagaDocument(topico, StatusVaga.LIVRE, null, false));
    }
}