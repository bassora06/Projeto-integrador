package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.repository.AdministradorRepository;
import fatec.pi.rod.onbus.repository.EmpresaRepository;
import fatec.pi.rod.onbus.repository.GestorEntradaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequiredArgsConstructor
@Service
public class AuthService {

    private final AdministradorRepository administradorRepository;
    private final EmpresaRepository empresaRepository;
    private final GestorEntradaRepository gestorEntradaRepository;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public Usuario login(String email, String senha, HttpServletRequest request) {
        Usuario authenticatedUser = null;

        // Check Administrador
        Administrador admin = administradorRepository.findByEmail(email).orElse(null);
        if (admin != null && admin.getAtivo() && passwordMatches(senha, admin.getSenha())) {
            authenticatedUser = admin;
        }

        // Check Empresa if admin not found
        if (authenticatedUser == null) {
            Empresa empresa = empresaRepository.findByEmail(email).orElse(null);
            if (empresa != null && empresa.getAtivo() && passwordMatches(senha, empresa.getSenha())) {
                authenticatedUser = empresa;
            }
        }

        // Check GestorEntrada if empresa not found
        if (authenticatedUser == null) {
            GestorEntrada gestor = gestorEntradaRepository.findByEmail(email).orElse(null);
            if (gestor != null && gestor.getAtivo() && passwordMatches(senha, gestor.getSenha())) {
                authenticatedUser = gestor;
            }
        }

        if (authenticatedUser == null) {
            throw new IllegalArgumentException("Credenciais inválidas ou conta inativa.");
        }

        // Store user in session
        HttpSession session = request.getSession();
        session.setAttribute("authenticatedUser", authenticatedUser);
        session.setAttribute("userRole", authenticatedUser.getTipo());
        session.setAttribute("userId", authenticatedUser.getId());

        return authenticatedUser;
    }

    public void logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    public Usuario getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Usuario) session.getAttribute("authenticatedUser");
        }
        return null;
    }

    public boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("authenticatedUser") != null;
    }

    private boolean passwordMatches(String raw, String stored) {
        // Fallback: if stored is not a BCrypt hash, compare plain (for existing seed data)
        if (stored == null) return false;
        boolean isBcrypt = stored.startsWith("$2a$") || stored.startsWith("$2b$") || stored.startsWith("$2y$");
        if (!isBcrypt) {
            return raw != null && raw.equals(stored);
        }
        return passwordEncoder.matches(raw, stored);
    }
}
