package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.repository.AdministradorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AdministradorService {

    private final AdministradorRepository administradorRepository;

    public Administrador salvar(Administrador administrador) {
        return administradorRepository.save(administrador);
    }
}