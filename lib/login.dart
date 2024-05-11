import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
      )),
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
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Ou',
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.4,
                      letterSpacing: 0.1,
                      color: const Color(0xFF000000),
                    ),
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
                      backgroundColor: const Color.fromRGBO(79, 55, 139, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    onPressed: () => {},
                    child: const Text('Entrar com Facebook')),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(41.9, 0, 42.9, 30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Ao entrar no sistema você está de acordo com nossa',
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.4,
                      letterSpacing: 0.1,
                      color: const Color(0xFF000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Política de Privacidade',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.3,
                          letterSpacing: 0.1,
                          color: const Color(0xFF4A548C),
                        ),
                      ),
                      const TextSpan(
                        text: ' e ',
                      ),
                      TextSpan(
                        text: 'Termos de Uso',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.3,
                          letterSpacing: 0.1,
                          color: const Color(0xFF4A548C),
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: 0.1,
                          color: const Color(0xFF000000),
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
    ));
  }
}
