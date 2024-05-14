import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/vectors/login_background.svg',
              alignment: Alignment.topCenter,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: const TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                onPressed: () => {},
                child: const Text('INICIAR AVENTURA'),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: const Text('Ou')),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(179, 38, 30, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
                onPressed: () => {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('./assets/vectors/icons/google.svg'),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('Entrar com Google'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(79, 55, 139, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
                onPressed: () => {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('./assets/vectors/icons/facebook.svg'),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                      child: Text('Entrar com Facebook'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Ao entrar no sistema você está de acordo com nossa ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    color: Color(0xFF000000),
                  ),
                  children: [
                    TextSpan(
                      text: 'Política de Privacidade',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        color: Color(0xFF4A548C),
                      ),
                    ),
                    TextSpan(
                      text: ' e ',
                    ),
                    TextSpan(
                      text: 'Termos de Uso',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        color: Color(0xFF4A548C),
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
