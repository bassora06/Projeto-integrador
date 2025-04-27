package fatec.pi.rod.onbus.web.controller;

import fatec.pi.rod.onbus.entity.Onibus;
import fatec.pi.rod.onbus.service.OnibusService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/v1/onibus")
public class OnibusController {

    private final OnibusService onibusService;

    @PostMapping
    public ResponseEntity<Onibus> create(@RequestBody Onibus onibus) {
        Onibus bus = onibusService.salvar(onibus);
        return ResponseEntity.status(HttpStatus.CREATED).body(bus);
    }
}
