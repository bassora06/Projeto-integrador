package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.service.AuthService;
import fatec.pi.rod.onbus.web.dto.LoginRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/auth") // Updated base path
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody LoginRequestDto loginRequest) {
        try {
            Object user = authService.login(loginRequest.getEmail(), loginRequest.getSenha());
            return ResponseEntity.ok(user);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Invalid login credentials");
        }
    }
}