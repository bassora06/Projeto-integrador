package fatec.pi.rod.onbus.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.time.Instant;

@Document(collection = "status_vagas") // A coleção que armazenará o estado das vagas
public class VagaDocument {

    @Id
    private String id; // O nome da vaga, ex: "vaga1"

    private StatusVaga status;
    private Instant inicioOcupacao; // Quando a vaga foi ocupada
    private boolean excedida;

    public VagaDocument() {
    }

    public VagaDocument(String id, StatusVaga status, Instant inicioOcupacao, boolean excedida) {
        this.id = id;
        this.status = status;
        this.inicioOcupacao = inicioOcupacao;
        this.excedida = excedida;
    }

    // Getters e Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public StatusVaga getStatus() { return status; }
    public void setStatus(StatusVaga status) { this.status = status; }
    public Instant getInicioOcupacao() { return inicioOcupacao; }
    public void setInicioOcupacao(Instant inicioOcupacao) { this.inicioOcupacao = inicioOcupacao; }
    public boolean isExcedida() { return excedida; }
    public void setExcedida(boolean excedida) { this.excedida = excedida; }
}