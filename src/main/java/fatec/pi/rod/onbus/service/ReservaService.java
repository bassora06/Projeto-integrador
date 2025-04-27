package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Reserva;
import fatec.pi.rod.onbus.repository.ReservaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ReservaService {

    private final ReservaRepository reservaRepository;

    @Transactional
    public Reserva salvar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    @Transactional(readOnly = true)
    public List<Reserva> buscarTodas() {
        return reservaRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Reserva buscarPorId(Integer id) {
        return reservaRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Reserva não encontrada.")
        );
    }
}