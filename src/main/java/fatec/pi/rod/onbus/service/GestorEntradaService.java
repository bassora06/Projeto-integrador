package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.GestorEntrada;
import fatec.pi.rod.onbus.repository.GestorEntradaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class GestorEntradaService {

    private final GestorEntradaRepository gestorEntradaRepository;

    public GestorEntrada salvar(GestorEntrada gestorEntrada) {
        return gestorEntradaRepository.save(gestorEntrada);
    }
}