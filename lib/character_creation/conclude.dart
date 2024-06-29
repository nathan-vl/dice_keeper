import 'dart:collection';

import 'package:dice_keeper/game_player/player_main.dart';
import 'package:dice_keeper/models/character.dart';
import 'package:dice_keeper/providers/UserProvider.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Conclude extends StatelessWidget {
  final Map<String, dynamic> currentCharacter;

  const Conclude({super.key, required this.currentCharacter});

  @override
  Widget build(BuildContext context) {
    final String userId = Provider.of<UserProvider>(context).uid;
    CharactersRepository.getByPlayerAndRoom(
      userId,
      currentCharacter['roomId'],
    ).then(
      (res) {
        if (res == null) {
          Character character = Character.fromMap(currentCharacter);
          CharactersRepository.insertCharacter(character);
        }
      },
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Tudo pronto para a jogatina",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(child: Image.asset("assets/confirm_splash.png")),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerMain(
                      // roomName: "[Nome da Sala]",
                      character: Character.fromMap(HashMap()),
                    ),
                  ),
                );
              },
              child: const Text(
                "Ir para a sala",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
