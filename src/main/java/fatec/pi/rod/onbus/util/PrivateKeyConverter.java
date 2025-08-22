package fatec.pi.rod.onbus.util;

import org.bouncycastle.asn1.pkcs.PrivateKeyInfo;
import org.bouncycastle.asn1.pkcs.RSAPrivateKey;
import org.bouncycastle.asn1.x509.AlgorithmIdentifier;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMParser;
import org.bouncycastle.asn1.pkcs.PKCSObjectIdentifiers;

import java.io.StringReader;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Security;
import java.security.spec.PKCS8EncodedKeySpec;

public class PrivateKeyConverter {

    public static PrivateKey convertPkcs1ToPkcs8(String pkcs1Key) throws Exception {
        // Add Bouncy Castle as a security provider
        Security.addProvider(new BouncyCastleProvider());

        // Parse the PKCS#1 key
        PEMParser pemParser = new PEMParser(new StringReader(pkcs1Key));
        Object parsedObject = pemParser.readObject();
        pemParser.close();

        if (!(parsedObject instanceof RSAPrivateKey)) {
            throw new IllegalArgumentException("Invalid PKCS#1 private key format");
        }

        RSAPrivateKey rsaPrivateKey = (RSAPrivateKey) parsedObject;

        // Convert to PKCS#8
        PrivateKeyInfo privateKeyInfo = new PrivateKeyInfo(
                new AlgorithmIdentifier(PKCSObjectIdentifiers.rsaEncryption), rsaPrivateKey);
        PKCS8EncodedKeySpec pkcs8Spec = new PKCS8EncodedKeySpec(privateKeyInfo.getEncoded());

        // Generate the PrivateKey object
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePrivate(pkcs8Spec);
    }
}