package fatec.pi.rod.onbus.entity;

import java.util.List;

/**
 * Classe utilitária para centralizar os nomes dos tópicos MQTT.
 */
public class Topicos {

    public static final String VAGA_1 = "vaga1";
    public static final String VAGA_2 = "vaga2";
    public static final String VAGA_3 = "vaga3";

    /**
     * Uma lista com todos os tópicos de vagas para facilitar a inscrição (subscribe).
     */
    public static final List<String> TODOS = List.of(VAGA_1, VAGA_2, VAGA_3);
}