package fatec.pi.rod.onbus.entity;

public class Log {


    public void logMensagem(String msg, Object... args) {
        System.out.println("📥 " + String.format(msg, args));
    }

    public void logErro(String msg, Object... args) {
        System.err.println("❌ " + msg);
    }

    public void logSucesso(String msg, Object... args) {
        System.out.println("✅ " + msg);
    }

    public void logTemporizador(String msg, Object... args) {
        System.out.println("⏰ " + msg);
    }

    public void logAtencao(String msg, Object... args){
        System.out.println("⚠️ " + msg);
    }
}
