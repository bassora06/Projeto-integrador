package fatec.pi.rod.onbus.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Log {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private String timestamp() {
        return "[" + LocalDateTime.now().format(FORMATTER) + "]";
    }

    public void logInfo(String message) {
        System.out.println(timestamp() + " ℹ️ INFO: " + message);
    }

    public void logSucesso(String message) {
        System.out.println(timestamp() + " ✅ SUCESSO: " + message);
    }

    public void logErro(String message) {
        System.err.println(timestamp() + " ❌ ERRO: " + message);
    }

    public void logAtencao(String message) {
        System.out.println(timestamp() + " ⚠️ ATENÇÃO: " + message);
    }

    public void logTemporizador(String message, Object... args) {
        System.out.println(timestamp() + " ⏱️ TEMPORIZADOR: " + String.format(message, args));
    }

    public void logDebug(String message) {
        System.out.println(timestamp() + " 🐞 DEBUG: " + message);
    }

}