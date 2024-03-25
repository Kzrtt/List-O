import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinishedPage extends StatefulWidget {
  const FinishedPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FinishedPageState createState() => _FinishedPageState();
}

class _FinishedPageState extends State<FinishedPage> {
  @override
  void initState() {
    super.initState();
    // Inicia uma contagem regressiva para fechar a página
    Future.delayed(const Duration(seconds: 2)).then((_) {
      // Verifica se o widget ainda está montado antes de chamar o Navigator.pop
      // para evitar erros caso a página tenha sido fechada manualmente antes.
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Definindo a cor de fundo da página como semi-transparente
      backgroundColor: Colors.transparent,
      body: Center(
        child: Lottie.asset("assets/finished.json"),
      ),
    );
  }
}
