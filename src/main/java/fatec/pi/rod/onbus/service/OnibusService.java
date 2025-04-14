//package fatec.pi.rod.onbus.service;
//
//import fatec.pi.rod.onbus.entity.Onibus;
//import fatec.pi.rod.onbus.repository.OnibusRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//@RequiredArgsConstructor
//@Service
//public class OnibusService {
//
//    private final OnibusRepository onibusRepository;
//
//    @Transactional
//    public Onibus salvar(Onibus onibus) {
//        return onibusRepository.save(onibus);
//    }
//}