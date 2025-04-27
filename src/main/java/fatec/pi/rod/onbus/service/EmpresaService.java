package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.repository.EmpresaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class EmpresaService {

    private final EmpresaRepository empresaRepository;

    public Empresa salvar(Empresa empresa) {
        return empresaRepository.save(empresa);
    }
}