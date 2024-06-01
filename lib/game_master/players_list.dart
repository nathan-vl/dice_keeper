import 'package:dice_keeper/widgets/card_character.dart';
import 'package:dice_keeper/game_player/player_main.dart';
import 'package:flutter/material.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Jogadores",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CardCharacter(
                  title: 'Nome do Jogador',
                  sub1: 'Nome do personagem',
                  sub2: 'Lv 10',
                  image: "assets/splash_1152.png",
                  onPressedFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PlayerMain(roomName: "[Nome da Sala]"),
                      ),
                    );
                  },
                ),
                CardCharacter(
                  title: 'Nome do Jogador',
                  sub1: 'Nome do personagem',
                  sub2: 'Lv 10',
                  image: "assets/splash_1152.png",
                  onPressedFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PlayerMain(roomName: "[Nome da Sala]"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
