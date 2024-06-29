import 'package:dice_keeper/game_player/general.dart';
import 'package:dice_keeper/game_player/inventory.dart';
import 'package:dice_keeper/game_player/skills.dart';
import 'package:flutter/material.dart';

class CharacterSheet extends StatelessWidget {
  final String characterId;
  const CharacterSheet({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: "Geral"),
                  Tab(text: "Habilidades"),
                  Tab(text: "Inventário"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    General(characterId: characterId),
                    Skills(characterId: characterId),
                    const Inventory(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
