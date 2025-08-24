package fatec.pi.rod.onbus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class OnbusApplication {

	public static void main(String[] args) {
		SpringApplication.run(OnbusApplication.class, args);
	}

}
