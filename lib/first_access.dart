import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstAccess extends StatefulWidget {
  const FirstAccess({super.key});

  @override
  State<FirstAccess> createState() => _FirstAccessState();
}

class _FirstAccessState extends State<FirstAccess> {
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
                SvgPicture.asset('assets/vectors/first_access_background.svg'),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(0, 0, 1, 32),
                    child: const Text(
                      'Agora, para continuar precisamos saber qual o seu papel no grupo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                    child: const Text(
                      'Eu sou...',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                      ),
                      onPressed: () => {},
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_library,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          ),
                          Text('MESTRE')
                        ],
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
                      ),
                      onPressed: () => {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/vectors/icons/d20.svg'),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          ),
                          const Text('JOGADOR')
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.2,
                        color: Color.fromRGBO(74, 84, 140, 1),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
