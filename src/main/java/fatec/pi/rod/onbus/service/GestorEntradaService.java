package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.repository.GestorEntradaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class GestorEntradaService {

    private final GestorEntradaRepository gestorEntradaRepository;

    @Transactional
    public GestorEntrada salvar(GestorEntrada gestorEntrada) {
        return gestorEntradaRepository.save(gestorEntrada);
    }

    @Transactional(readOnly = true)
    public List<GestorEntrada> buscarTodos() {
        return gestorEntradaRepository.findAll();
    }

    @Transactional(readOnly = true)
    public GestorEntrada buscarPorId(Long id) {
        return gestorEntradaRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Gestor de entrada não encontrado.")
        );
    }
}