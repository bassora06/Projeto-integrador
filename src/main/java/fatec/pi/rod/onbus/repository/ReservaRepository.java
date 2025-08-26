package fatec.pi.rod.onbus.repository;

import fatec.pi.rod.onbus.entity.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservaRepository extends JpaRepository<Reserva, Integer> {
}