package fatec.pi.rod.onbus.service;

import fatec.pi.rod.onbus.entity.Usuario;
import fatec.pi.rod.onbus.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    @Transactional
    public Usuario salvar(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    @Transactional(readOnly = true)
    public List<Usuario> buscarTodos() {
        return usuarioRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Usuario buscarPorId(Long id) {
        return usuarioRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Usuário não encontrado.")
        );
    }

    @Transactional
    public Usuario editarSenha(Long id, String senhaAtual, String novaSenha, String confirmaSenha) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado"));

        if (!usuario.getSenha().equals(senhaAtual)) {
            throw new IllegalArgumentException("Senha atual incorreta");
        }

        if (!novaSenha.equals(confirmaSenha)) {
            throw new IllegalArgumentException("Nova senha e confirmação de senha não coincidem");
        }

        usuario.setSenha(novaSenha);
        return usuarioRepository.save(usuario);
    }


}
