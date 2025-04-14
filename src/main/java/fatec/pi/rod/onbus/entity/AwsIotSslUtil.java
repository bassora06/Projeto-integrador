package fatec.pi.rod.onbus.entity;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.KeyFactory;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.KeyManagerFactory;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class AwsIotSslUtil {

    public static SSLSocketFactory getSocketFactory(String caCrtFile, String crtFile, String keyFile) throws Exception {
        // Load CA certificate
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        FileInputStream caFis = new FileInputStream(caCrtFile);
        X509Certificate caCert = (X509Certificate) cf.generateCertificate(caFis);

        // Load client certificate
        FileInputStream certFis = new FileInputStream(crtFile);
        X509Certificate cert = (X509Certificate) cf.generateCertificate(certFis);

        // Load private key
        PrivateKey key = loadPrivateKey(keyFile);

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

        return context.getSocketFactory();
    }

    private static PrivateKey loadPrivateKey(String keyFilePath) throws Exception {
        try {
            StringBuilder keyBuilder = new StringBuilder();
            BufferedReader reader = new BufferedReader(new FileReader(new File(keyFilePath)));
            String line;
            boolean inKey = false;
            while ((line = reader.readLine()) != null) {
                if (line.contains("BEGIN PRIVATE KEY")) {
                    inKey = true;
                } else if (line.contains("END PRIVATE KEY")) {
                    break;
                } else if (inKey) {
                    keyBuilder.append(line);
                }
            }
            reader.close();

            byte[] encoded = Base64.getDecoder().decode(keyBuilder.toString());
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
            KeyFactory kf = KeyFactory.getInstance("RSA");
            return kf.generatePrivate(keySpec);
        } catch(Exception e){
            throw new RuntimeException("Erro ao carregar os certificados SSL para AWS IoT: " + e.getMessage(), e);
        }
    }
}

