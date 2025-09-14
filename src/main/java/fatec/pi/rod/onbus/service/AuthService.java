package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.repository.AdministradorRepository;
import fatec.pi.rod.onbus.repository.EmpresaRepository;
import fatec.pi.rod.onbus.repository.GestorEntradaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AuthService {

    private final AdministradorRepository administradorRepository;
    private final EmpresaRepository empresaRepository;
    private final GestorEntradaRepository gestorEntradaRepository;

    public Object login(String email, String senha) {
        Administrador admin = administradorRepository.findByEmail(email).orElse(null);
        if (admin != null && admin.getSenha().equals(senha)) {
            return admin;
        }

        Empresa empresa = empresaRepository.findByEmail(email).orElse(null);
        if (empresa != null && empresa.getSenha().equals(senha)) {
            return empresa;
        }

        GestorEntrada gestor = gestorEntradaRepository.findByEmail(email).orElse(null);
        if (gestor != null && gestor.getSenha().equals(senha)) {
            return gestor;
        }

        throw new IllegalArgumentException("Credenciais inválidas.");
    }
}