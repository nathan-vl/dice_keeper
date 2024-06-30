import 'package:dice_keeper/dice_roller.dart';
import 'package:dice_keeper/game_player/character_sheet.dart';
import 'package:flutter/material.dart';

class PlayerMain extends StatelessWidget {
  final String characterId;

  const PlayerMain({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.view_list), text: 'Ficha'),
            Tab(icon: Icon(Icons.casino), text: 'Dados'),
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("roomName"),
        ),
        body: TabBarView(
          children: [
            CharacterSheet(characterId: characterId),
            const DiceRoller(),
          ],
        ),
      ),
    );
  }
}
