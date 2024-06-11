import 'package:dice_keeper/first_access.dart';
import 'package:dice_keeper/room_selection.dart';
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
            Image.asset('assets/login_background.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FirstAccess(),
                          ),
                        );
                      },
                      child: const Text('INICIAR AVENTURA'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Ou'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RoomSelection(),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        './assets/vectors/icons/google.svg',
                      ),
                      label: const Text("Entrar com Google"),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(179, 38, 30, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        './assets/vectors/icons/facebook.svg',
                      ),
                      label: const Text("Entrar com Facebook"),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(79, 55, 139, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
