package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Administrador;
import fatec.pi.rod.onbus.entity.Empresa;
import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.repository.AdministradorRepository;
import fatec.pi.rod.onbus.repository.EmpresaRepository;
import fatec.pi.rod.onbus.repository.GestorEntradaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/init")
public class InitController {

    private final AdministradorRepository administradorRepository;
    private final EmpresaRepository empresaRepository;
    private final GestorEntradaRepository gestorEntradaRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/test-users")
    public ResponseEntity<String> createTestUsers() {
        try {
            // Check if users already exist
            if (administradorRepository.findByEmail("admin@test.com").isPresent()) {
                return ResponseEntity.ok("Test users already exist");
            }

            // Create Admin user
            Administrador admin = new Administrador();
            admin.setNome("Admin Test");
            admin.setEmail("admin@test.com");
            admin.setSenha("test123"); // This will be BCrypt encoded by the setSenha method
            admin.setAtivo(true);
            administradorRepository.save(admin);

            // Create Company user
            Empresa empresa = new Empresa();
            empresa.setNome("Empresa Test");
            empresa.setEmail("empresa@test.com");
            empresa.setSenha("test123"); // This will be BCrypt encoded by the setSenha method
            empresa.setAtivo(true);
            empresa.setCnpj("12345678901234");
            empresaRepository.save(empresa);

            // Create Entry Manager user
            GestorEntrada gestor = new GestorEntrada();
            gestor.setNome("Gestor Test");
            gestor.setEmail("gestor@test.com");
            gestor.setSenha("test123"); // This will be BCrypt encoded by the setSenha method
            gestor.setAtivo(true);
            gestorEntradaRepository.save(gestor);

            return ResponseEntity.ok("Test users created successfully! You can now login with:\n" +
                    "- admin@test.com / test123 (ADMIN)\n" +
                    "- empresa@test.com / test123 (EMPRESA)\n" +
                    "- gestor@test.com / test123 (GESTOR)");

        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("Error creating test users: " + e.getMessage());
        }
    }

    @GetMapping("/users")
    public ResponseEntity<String> listUsers() {
        try {
            long adminCount = administradorRepository.count();
            long empresaCount = empresaRepository.count();
            long gestorCount = gestorEntradaRepository.count();

            return ResponseEntity.ok(String.format(
                    "Users in database:\n" +
                    "- Administrators: %d\n" +
                    "- Companies: %d\n" +
                    "- Entry Managers: %d",
                    adminCount, empresaCount, gestorCount
            ));
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("Error listing users: " + e.getMessage());
        }
    }
}