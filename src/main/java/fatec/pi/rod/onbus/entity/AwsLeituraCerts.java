package fatec.pi.rod.onbus.entity;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.KeyManagerFactory;
import java.io.InputStream;
import java.security.KeyFactory;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

public class AwsLeituraCerts {

    public static SSLSocketFactory getSocketFactory(String caCrtFile, String crtFile, String keyFile) throws Exception {
        // Log de início do processo de carregamento do certificado CA
        System.out.println("🔍 Procurando o arquivo de certificado CA: " + caCrtFile);
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        InputStream caInputStream = AwsLeituraCerts.class.getClassLoader().getResourceAsStream(caCrtFile);
        if (caInputStream == null) {
            throw new RuntimeException("❌ Arquivo de certificado CA não encontrado: " + caCrtFile);
        }
        System.out.println("✅ Arquivo de certificado CA encontrado!");
        X509Certificate caCert = (X509Certificate) cf.generateCertificate(caInputStream);
        System.out.println("✅ Certificado CA carregado com sucesso!");

        // Log de início do processo de carregamento do certificado do cliente
        System.out.println("🔍 Procurando o arquivo de certificado do cliente: " + crtFile);
        InputStream certInputStream = AwsLeituraCerts.class.getClassLoader().getResourceAsStream(crtFile);
        if (certInputStream == null) {
            throw new RuntimeException("❌ Arquivo de certificado do cliente não encontrado: " + crtFile);
        }
        System.out.println("✅ Arquivo de certificado do cliente encontrado!");
        X509Certificate cert = (X509Certificate) cf.generateCertificate(certInputStream);
        System.out.println("✅ Certificado do cliente carregado com sucesso!");

        // Log de início do processo de carregamento da chave privada
        System.out.println("🔍 Procurando o arquivo de chave privada: " + keyFile);
        InputStream keyInputStream = AwsLeituraCerts.class.getClassLoader().getResourceAsStream(keyFile);
        if (keyInputStream == null) {
            throw new RuntimeException("❌ Arquivo de chave privada não encontrado: " + keyFile);
        }
        System.out.println("✅ Arquivo de chave privada encontrado!");
        PrivateKey key = loadPrivateKey(keyInputStream);
        System.out.println("✅ Chave privada carregada com sucesso!");

        // Criar keystore para CA
        System.out.println("🔒 Criando o keystore da CA...");
        KeyStore caKs = KeyStore.getInstance(KeyStore.getDefaultType());
        caKs.load(null, null);
        caKs.setCertificateEntry("ca-certificate", caCert);
        TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
        tmf.init(caKs);

        // Criar keystore para o cliente
        System.out.println("🔒 Criando o keystore do cliente...");
        KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
        ks.load(null, null);
        ks.setCertificateEntry("certificate", cert);
        ks.setKeyEntry("private-key", key, "".toCharArray(), new java.security.cert.Certificate[]{cert});
        KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
        kmf.init(ks, "".toCharArray());

        // Configuração do SSLContext
        System.out.println("🔐 Configurando o SSLContext...");
        SSLContext context = SSLContext.getInstance("TLSv1.2");
        context.init(kmf.getKeyManagers(), tmf.getTrustManagers(), null);

        System.out.println("✅ SocketFactory criado com sucesso!");
        return context.getSocketFactory();
    }

    private static PrivateKey loadPrivateKey(InputStream keyInputStream) throws Exception {
        byte[] keyBytes = keyInputStream.readAllBytes();
        String keyPem = new String(keyBytes)
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replaceAll("[\\r\\n]+", "") // Remover quebras de linha
                .trim();

        System.out.println("🔒 Decodificando a chave privada...");
        byte[] decoded = Base64.getDecoder().decode(keyPem);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(decoded);
        return KeyFactory.getInstance("RSA").generatePrivate(keySpec);
    }
}
