import 'package:dice_keeper/create_campaign.dart';
import 'package:dice_keeper/join_campaign.dart';
import 'package:dice_keeper/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstAccess extends StatefulWidget {
  const FirstAccess({super.key});

  @override
  State<FirstAccess> createState() => _FirstAccessState();
}

class _FirstAccessState extends State<FirstAccess> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              SvgPicture.asset(
                'assets/vectors/first_access_background.svg',
                alignment: Alignment.topCenter,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(0, 0, 1, 32),
                    child: Text(
                      'Agora, para continuar precisamos saber qual o seu papel no grupo.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                    child: Text(
                      'Eu sou...',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateCampaign(),
                          ),
                        );
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_library,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JoinCampaign(),
                          ),
                        );
                      },
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
                ],
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
              TextButton(
                onPressed: () {
                  logout();
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
