package fatec.pi.rod.onbus.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;

@Configuration
@EnableWebSecurity
public class SpringSecConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf().disable() // Desativa proteção CSRF
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().permitAll() // Permite qualquer requisição
                );
//                .formLogin().disable() // Desativa formulário de login
//                .httpBasic().disable(); // Desativa autenticação básica

        return http.build();
    }
}
