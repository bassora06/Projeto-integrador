package fatec.pi.rod.onbus.config;

import fatec.pi.rod.onbus.entity.Usuario;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;

@Component
public class SessionAuthFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null && session.getAttribute("authenticatedUser") != null) {
            Usuario user = (Usuario) session.getAttribute("authenticatedUser");
            
            // Create Spring Security authentication object
            SimpleGrantedAuthority authority = new SimpleGrantedAuthority(user.getTipo().toString());
            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                user.getEmail(),
                null,
                Collections.singletonList(authority)
            );
            
            // Set user details
            authToken.setDetails(user);
            
            // Set authentication in Security Context
            SecurityContextHolder.getContext().setAuthentication(authToken);
        }
        
        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        String path = request.getRequestURI();
        // Skip filter for public endpoints
        return path.startsWith("/api/v1/auth/login") || 
               path.startsWith("/api/v1/auth/status") ||
               (path.startsWith("/api/v1/onibus") && "GET".equals(request.getMethod())) ||
               path.startsWith("/v3/api-docs") ||
               path.startsWith("/swagger-ui");
    }
}