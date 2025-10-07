package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.service.AuthService;
import fatec.pi.rod.onbus.web.dto.LoginRequestDto;
import fatec.pi.rod.onbus.web.dto.LoginResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequestDto loginRequest, HttpServletRequest request) {
        try {
            Usuario user = authService.login(loginRequest.getEmail(), loginRequest.getSenha(), request);
            
            HttpSession session = request.getSession();
            String sessionId = session.getId();
            Integer sessionTimeout = session.getMaxInactiveInterval();
            
            LoginResponseDto response = LoginResponseDto.fromUser(user, sessionId, sessionTimeout);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Credenciais inválidas ou conta inativa");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Erro interno do servidor");
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<String> logout(HttpServletRequest request) {
        try {
            authService.logout(request);
            return ResponseEntity.ok("Logout realizado com sucesso");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Erro ao realizar logout");
        }
    }

    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUser(HttpServletRequest request) {
        try {
            Usuario currentUser = authService.getCurrentUser(request);
            if (currentUser == null) {
                return ResponseEntity.status(401).body("Usuário não autenticado");
            }
            
            HttpSession session = request.getSession(false);
            String sessionId = session != null ? session.getId() : null;
            Integer sessionTimeout = session != null ? session.getMaxInactiveInterval() : null;
            
            LoginResponseDto response = LoginResponseDto.fromUser(currentUser, sessionId, sessionTimeout);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Erro ao obter usuário atual");
        }
    }

    @GetMapping("/status")
    public ResponseEntity<?> getAuthStatus(HttpServletRequest request) {
        boolean isAuthenticated = authService.isAuthenticated(request);
        return ResponseEntity.ok(new AuthStatusResponse(isAuthenticated));
    }

    public static class AuthStatusResponse {
        private boolean authenticated;
        
        public AuthStatusResponse(boolean authenticated) {
            this.authenticated = authenticated;
        }
        
        public boolean isAuthenticated() {
            return authenticated;
        }
        
        public void setAuthenticated(boolean authenticated) {
            this.authenticated = authenticated;
        }
    }
}