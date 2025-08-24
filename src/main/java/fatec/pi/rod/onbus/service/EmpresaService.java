package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.repository.EmpresaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class EmpresaService {

    private final EmpresaRepository empresaRepository;

    @Transactional
    public Empresa salvar(Empresa empresa) {
        return empresaRepository.save(empresa);
    }

    @Transactional(readOnly = true)
    public List<Empresa> buscarTodas() {
        return empresaRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Empresa buscarPorId(Long id) {
        return empresaRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Empresa não encontrada.")
        );
    }
}