package fatec.pi.rod.onbus.entity;

import org.springframework.scheduling.annotation.Scheduled;

import java.time.Duration;
import java.time.Instant;
import java.util.Map;

public class VagaService {

    private final Log log = new Log();
    private final MqttService mqttService;
    private static final Duration LIMITE = Duration.ofMinutes(1);

    public VagaService(MqttService mqttService) {
        this.mqttService = mqttService;
    }

    @Scheduled(fixedRate = 60_000)
    public void verificarExpiracoes() {
        Instant agora = Instant.now();
        log.logInfo("🔍 Verificando expiração de vagas...");

        Map<String, VagaStatus> vagaStatusMap = mqttService.getCache();

        vagaStatusMap.forEach((topic, status) -> {
            if (status.ocupada() && status.inicioOcupacao() != null) {
                Duration tempoOcupado = Duration.between(status.inicioOcupacao(), agora);

                if (tempoOcupado.compareTo(LIMITE) > 0) {
                    log.logAtencao("⚠️ Vaga no tópico '%s' EXPIRADA após %d minutos.".formatted(topic, tempoOcupado.toMinutes()));
                    mqttService.publicarTimeout(topic);
                    vagaStatusMap.put(topic, new VagaStatus(false, null));
                } else {
                    log.logInfo("✅ Vaga no tópico '%s' ainda dentro do tempo (ocupada há %d minutos).".formatted(topic, tempoOcupado.toMinutes()));
                }
            } else {
                log.logInfo("🟢 Vaga no tópico '%s' está livre ou nunca foi ocupada.".formatted(topic));
            }
        });
    }

    public StatusVaga getStatusVaga(String topico) {
        VagaStatus status = mqttService.getCache().get(topico);

        if (status == null || !status.ocupada()) {
            return StatusVaga.LIVRE;
        }

        Duration tempo = Duration.between(status.inicioOcupacao(), Instant.now());
        return tempo.compareTo(LIMITE) > 0 ? StatusVaga.EXPIRADA : StatusVaga.OCUPADA;
    }
}
