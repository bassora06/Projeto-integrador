package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Onibus;
import fatec.pi.rod.onbus.repository.OnibusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class OnibusService {

    private final OnibusRepository onibusRepository;

    @Transactional
    public Onibus salvar(Onibus onibus) {
        return onibusRepository.save(onibus);
    }

    @Transactional(readOnly = true)
    public List<Onibus> buscarTodos() {
        return onibusRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Onibus buscarPorId(Long id) {
        return onibusRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Ônibus não encontrado.")
        );
    }
}