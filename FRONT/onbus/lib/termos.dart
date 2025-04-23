import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const Termos());
}

class Termos extends StatelessWidget {
  const Termos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
              clipper: WaveClipper(reverse: true),
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 55, 39, 166),
                      Color.fromARGB(255, 40, 8, 58),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                  Positioned(
                    left: 15,
                    bottom: 50,
                    child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  ],
                ),
                ),
              ),
              const SizedBox(height: 40),
              
              Image.asset(
                'lib/assets/images/onbus.png',
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              const Text(
                'Termos & Condições',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 40, 0, 104),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Aqui estão os termos e condições do OnBus. Ao usar o aplicativo, você concorda com estes termos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: '1. Uso do Aplicativo\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '1.1. O Aplicativo é disponibilizado apenas para uso pessoal e não comercial.\n',
                  ),
                  TextSpan(
                    text:
                        '1.2. Você concorda em usar o Aplicativo de forma legal e adequada, em conformidade com todas as leis aplicáveis e com estes Termos.\n',
                  ),
                  TextSpan(
                    text:
                        '1.3. Qualquer tentativa de engenharia reversa, descompilação ou modificação do Aplicativo é estritamente proibida.\n\n',
                  ),
                  TextSpan(
                    text: '2. Criação de Conta\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '2.1. Para acessar algumas funcionalidades do Aplicativo, pode ser necessário criar uma conta.\n',
                  ),
                  TextSpan(
                    text:
                        '2.2. Você é responsável por manter a confidencialidade de suas credenciais de login e por todas as atividades realizadas através de sua conta.\n',
                  ),
                  TextSpan(
                    text:
                        '2.3. A Empresa reserva-se o direito de suspender ou encerrar contas que violarem estes Termos ou por qualquer outro motivo que julgar adequado.\n\n',
                  ),
                  TextSpan(
                    text: '3. Coleta e Uso de Dados\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '3.1. Ao usar o Aplicativo, você concorda com a coleta e o uso de informações conforme descrito em nossa Política de Privacidade.\n',
                  ),
                  TextSpan(
                    text:
                        '3.2. A Empresa poderá coletar dados pessoais e anônimos para melhorar a funcionalidade e a experiência do usuário no Aplicativo.\n\n',
                  ),
                  TextSpan(
                    text: '4. Licença de Uso\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '4.1. A Empresa concede ao Usuário uma licença limitada, não exclusiva, não transferível e revogável para usar o Aplicativo de acordo com estes Termos.\n',
                  ),
                  TextSpan(
                    text:
                        '4.2. Todos os direitos que não foram expressamente concedidos a você nestes Termos estão reservados à Empresa.\n\n',
                  ),
                  TextSpan(
                    text: '5. Propriedade Intelectual\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '5.1. Todos os direitos de propriedade intelectual relacionados ao Aplicativo, incluindo, sem limitação, textos, gráficos, logotipos, ícones, imagens e software, pertencem à Empresa ou a seus licenciadores.\n',
                  ),
                  TextSpan(
                    text:
                        '5.2. O uso indevido de qualquer propriedade intelectual do Aplicativo é estritamente proibido.\n\n',
                  ),
                  TextSpan(
                    text: '6. Atualizações e Modificações\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '6.1. A Empresa reserva-se o direito de modificar ou descontinuar o Aplicativo, ou qualquer parte dele, a qualquer momento, sem aviso prévio.\n',
                  ),
                  TextSpan(
                    text:
                        '6.2. A Empresa poderá atualizar estes Termos periodicamente. É de sua responsabilidade revisar regularmente os Termos atualizados.\n\n',
                  ),
                  TextSpan(
                    text: '7. Isenção de Garantias\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '7.1. O Aplicativo é fornecido "como está" e "conforme disponível". A Empresa não oferece garantias de que o Aplicativo será ininterrupto, livre de erros ou seguro.\n',
                  ),
                  TextSpan(
                    text:
                        '7.2. A Empresa não garante a precisão, confiabilidade ou atualidade das informações fornecidas pelo Aplicativo.\n\n',
                  ),
                  TextSpan(
                    text: '8. Limitação de Responsabilidade\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '8.1. Em nenhuma circunstância a Empresa será responsável por quaisquer danos diretos, indiretos, incidentais, especiais ou consequenciais decorrentes do uso ou da impossibilidade de uso do Aplicativo.\n',
                  ),
                  TextSpan(
                    text:
                        '8.2. A Empresa não se responsabiliza por qualquer perda de dados ou danos causados por bugs, falhas ou interrupções no Aplicativo.\n\n',
                  ),
                  TextSpan(
                    text: '9. Rescisão\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '9.1. A Empresa pode rescindir ou suspender seu acesso ao Aplicativo a qualquer momento, por qualquer motivo, incluindo, mas não se limitando, à violação destes Termos.\n',
                  ),
                  TextSpan(
                    text:
                        '9.2. Após a rescisão, as disposições destes Termos que por sua natureza devam permanecer vigentes, continuarão a ser aplicáveis.\n\n',
                  ),
                  TextSpan(
                    text: '10. Legislação Aplicável e Jurisdição\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '10.1. Estes Termos são regidos pelas leis do [País], sem consideração aos princípios de conflitos de leis.\n',
                  ),
                  TextSpan(
                    text:
                        '10.2. Qualquer disputa decorrente ou relacionada a estes Termos será resolvida exclusivamente nos tribunais competentes localizados em [Cidade/Estado].\n\n',
                  ),
                  TextSpan(
                    text: '11. Contato\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Se você tiver qualquer dúvida sobre estes Termos, entre em contato conosco através do e-mail onBusPI@gmail.com.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

              // Abstract curved footer
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 40, 8, 58),
                      Color.fromARGB(255, 55, 39, 166),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 5,
                    child: IconButton(
                    icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
                    onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final bool reverse;

  WaveClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    final path = Path();
    
    if (reverse) {
      path.moveTo(0, size.height);
      path.quadraticBezierTo(
        size.width * 0.25, size.height - 30,
        size.width * 0.5, size.height - 20);
      path.quadraticBezierTo(
        size.width * 0.75, size.height - 10,
        size.width, size.height - 30);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        size.width * 0.25, 30,
        size.width * 0.5, 20);
      path.quadraticBezierTo(
        size.width * 0.75, 10,
        size.width, 30);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
