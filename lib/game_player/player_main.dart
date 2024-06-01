import 'package:dice_keeper/dice_roller.dart';
import 'package:dice_keeper/game_player/character_sheet.dart';
import 'package:flutter/material.dart';

class PlayerMain extends StatelessWidget {
  final String roomName;

  const PlayerMain({
    super.key,
    required this.roomName,
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
          title: Text(roomName),
        ),
        body: const TabBarView(
          children: [
            CharacterSheet(), // Jogadores
            DiceRoller(),
          ],
        ),
      ),
    );
  }
}
