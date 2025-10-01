package fatec.pi.rod.onbus.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SpringSecConfig {

    private final SessionAuthFilter sessionAuthFilter;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .headers(headers -> headers
                        .frameOptions(frameOptions -> frameOptions.sameOrigin()) // Allow H2 console frames
                )
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false)
                )
                .authorizeHttpRequests(auth -> auth
                        // Public authentication endpoints
                        .requestMatchers("/api/v1/auth/login", "/api/v1/auth/status").permitAll()
                        
                        // Initialization endpoints (for testing)
                        .requestMatchers("/api/v1/init/**").permitAll()
                        
                        // H2 Console (for development/testing)
                        .requestMatchers("/h2-console/**").permitAll()
                        
                        // Public endpoints (read-only access to buses)
                        .requestMatchers(HttpMethod.GET, "/api/v1/onibus/**").permitAll()
                        
                        // Swagger/OpenAPI documentation
                        .requestMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll()
                        
                        // Admin-only endpoints
                        .requestMatchers("/api/v1/administrador/**").hasAuthority("ROLE_ADMIN")
                        
                        // Company endpoints
                        .requestMatchers("/api/v1/empresa/**").hasAuthority("ROLE_EMPRESA")
                        
                        // Entry manager endpoints  
                        .requestMatchers("/api/v1/gestor/**").hasAuthority("ROLE_GESTORENTRADA")
                        
                        // Protected auth endpoints (require authentication)
                        .requestMatchers("/api/v1/auth/logout", "/api/v1/auth/me").authenticated()
                        
                        // All other endpoints require authentication
                        .anyRequest().authenticated()
                )
                .addFilterBefore(sessionAuthFilter, UsernamePasswordAuthenticationFilter.class)
                .formLogin(form -> form.disable())
                .httpBasic(basic -> basic.disable());

        return http.build();
    }
}
