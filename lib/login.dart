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
            Column(
              children: [
                SvgPicture.asset('assets/vectors/login_background.svg'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      onPressed: () => {},
                      child: const Text('INICIAR AVENTURA')),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Ou',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(179, 38, 30, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      onPressed: () => {},
                      child: const Text('Entrar com Google')),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () => {},
                      child: const Text('Entrar com Facebook')),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(41.9, 0, 42.9, 30),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text:
                          'Ao entrar no sistema você está de acordo com nossa ',
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
          ],
        ),
      ),
    );
  }
}
