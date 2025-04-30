package fatec.pi.rod.onbus.entity;

import java.time.Instant;

public record VagaStatus(boolean ocupada, Instant inicioOcupacao) { }
