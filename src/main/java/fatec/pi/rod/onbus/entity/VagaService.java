package fatec.pi.rod.onbus.entity;

import fatec.pi.rod.onbus.repository.VagaRepository;
import org.springframework.data.mongodb.core.aggregation.SelectionOperators;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.time.Duration;
import java.time.Instant;
import java.util.List;

@Component
public class VagaService {

    private final Log log = new Log();
    private final VagaRepository vagaRepository;
    private static final Duration LIMITE = Duration.ofSeconds(10);

    public VagaService(VagaRepository vagaRepository) {
        this.vagaRepository = vagaRepository;
    }

    @Scheduled(fixedRate = 10_000)
    public void verificarExpiracoes() {
        Instant agora = Instant.now();
        Instant tempoLimite = agora.minus(LIMITE);
        log.logInfo("🔍 Verificando expiração de vagas...");

        List<VagaDocument> vagasParaExpirar = vagaRepository.findByStatusAndExcedidaAndInicioOcupacaoBefore(StatusVaga.OCUPADA, false, tempoLimite);

        for (VagaDocument vaga : vagasParaExpirar) {
            vaga.setExcedida(true);
            vaga.setStatus(StatusVaga.EXPIRADA);
            vagaRepository.save(vaga);
            log.logTemporizador("Vaga no tópico '%s' EXPIRADA.", vaga.getId());
        }
    }

    public VagaDocument getStatusVaga(String topico) {
        return vagaRepository.findById(topico).orElse(new VagaDocument(topico, StatusVaga.LIVRE, null, false));
    }
}
