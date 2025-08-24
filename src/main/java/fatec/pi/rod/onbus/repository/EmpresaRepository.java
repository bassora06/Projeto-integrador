package fatec.pi.rod.onbus.repository;

import fatec.pi.rod.onbus.entity.Empresa;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmpresaRepository extends JpaRepository<Empresa, Long> {
}