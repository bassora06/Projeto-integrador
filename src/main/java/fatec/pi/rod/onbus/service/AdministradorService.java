package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.repository.AdministradorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AdministradorService {

    private final AdministradorRepository administradorRepository;

    @Transactional
    public Administrador salvar(Administrador administrador) {
        return administradorRepository.save(administrador);
    }

    @Transactional(readOnly = true)
    public List<Administrador> buscarTodos() {
        return administradorRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Administrador buscarPorId(Long id) {
        return administradorRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Administrador não encontrado.")
        );
    }
}