package fatec.pi.rod.onbus.repository;

import fatec.pi.rod.onbus.entity.VagaDocument;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;
import java.time.Instant;

public interface VagaRepository extends MongoRepository<VagaDocument, String> {

    // Query customizada para encontrar vagas ocupadas que não excederam o tempo
    // e que foram ocupadas antes de um certo tempo limite.
    List<VagaDocument> findByStatusAndExcedidaAndInicioOcupacaoBefore(
            fatec.pi.rod.onbus.entity.StatusVaga status,
            boolean excedida,
            Instant tempoLimite
    );
}