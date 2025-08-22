package fatec.pi.rod.onbus.repository;

import fatec.pi.rod.onbus.entity.GestorEntrada;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GestorEntradaRepository extends JpaRepository<GestorEntrada, Long> {
    Optional<GestorEntrada> findByEmail(String email);
}