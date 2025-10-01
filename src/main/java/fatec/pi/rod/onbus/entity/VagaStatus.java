package fatec.pi.rod.onbus.entity;

import java.time.Instant;

public record VagaStatus(boolean ocupada, Instant inicioOcupacao, boolean expirada) {
    public VagaStatus(boolean ocupada, Instant inicioOcupacao) {
        this(ocupada, inicioOcupacao, false);
    }
}
