package fatec.pi.rod.onbus.repository;

import fatec.pi.rod.onbus.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
}