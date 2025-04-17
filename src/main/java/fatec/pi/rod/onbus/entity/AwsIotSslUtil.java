package fatec.pi.rod.onbus.entity;

import fatec.pi.rod.onbus.util.PrivateKeyConverter;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import java.io.InputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.KeyManagerFactory;

public class AwsIotSslUtil {

    public static SSLSocketFactory getSocketFactory(String caCrtFile, String crtFile, String keyFile) throws Exception {
        // Load CA certificate
        System.out.println("🔍 Procurando o arquivo de certificado CA: " + caCrtFile);
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        InputStream caInputStream = AwsIotSslUtil.class.getClassLoader().getResourceAsStream(caCrtFile);
        if (caInputStream == null) {
            throw new RuntimeException("❌ Arquivo de certificado CA não encontrado: " + caCrtFile);
        }
        System.out.println("✅ Arquivo de certificado CA encontrado!");
        X509Certificate caCert = (X509Certificate) cf.generateCertificate(caInputStream);
        System.out.println("✅ Certificado CA carregado com sucesso!");

        // Load client certificate
        System.out.println("🔍 Procurando o arquivo de certificado do cliente: " + crtFile);
        InputStream certInputStream = AwsIotSslUtil.class.getClassLoader().getResourceAsStream(crtFile);
        if (certInputStream == null) {
            throw new RuntimeException("❌ Arquivo de certificado do cliente não encontrado: " + crtFile);
        }
        System.out.println("✅ Arquivo de certificado do cliente encontrado!");
        X509Certificate cert = (X509Certificate) cf.generateCertificate(certInputStream);
        System.out.println("✅ Certificado do cliente carregado com sucesso!");

        // Load private key
        System.out.println("🔍 Procurando o arquivo de chave privada: " + keyFile);
        InputStream keyInputStream = AwsIotSslUtil.class.getClassLoader().getResourceAsStream(keyFile);
        if (keyInputStream == null) {
            throw new RuntimeException("❌ Arquivo de chave privada não encontrado: " + keyFile);
        }
        System.out.println("✅ Arquivo de chave privada encontrado!");
        PrivateKey key = loadPrivateKey(keyInputStream);
        System.out.println("✅ Chave privada carregada com sucesso!");

        // CA keystore
        KeyStore caKs = KeyStore.getInstance(KeyStore.getDefaultType());
        caKs.load(null, null);
        caKs.setCertificateEntry("ca-certificate", caCert);
        TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
        tmf.init(caKs);

        // Client keystore
        KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
        ks.load(null, null);
        ks.setCertificateEntry("certificate", cert);
        ks.setKeyEntry("private-key", key, "".toCharArray(), new java.security.cert.Certificate[]{cert});
        KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
        kmf.init(ks, "".toCharArray());

        // SSL
        SSLContext context = SSLContext.getInstance("TLSv1.2");
        context.init(kmf.getKeyManagers(), tmf.getTrustManagers(), null);

        System.out.println("✅ SocketFactory criado com sucesso!");
        return context.getSocketFactory();
    }

    private static PrivateKey loadPrivateKey(InputStream keyInputStream) throws Exception {
        StringBuilder keyBuilder = new StringBuilder();
        try (keyInputStream) {
            byte[] keyBytes = keyInputStream.readAllBytes();
            String keyContent = new String(keyBytes);
            System.out.println("🔑 Key Content: " + keyContent); // Debugging log
            return PrivateKeyConverter.convertPkcs1ToPkcs8(keyContent);
        }
    }
}