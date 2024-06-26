import 'package:dice_keeper/dice_roller.dart';
import 'package:dice_keeper/game_master/locations.dart';
import 'package:dice_keeper/game_master/npcs.dart';
import 'package:dice_keeper/game_master/players_list.dart';
import 'package:flutter/material.dart';

class GameMasterMain extends StatelessWidget {
  final String roomName;

  const GameMasterMain({
    super.key,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.view_list), text: 'Jogadores'),
            Tab(icon: Icon(Icons.casino), text: 'Dados'),
            Tab(icon: Icon(Icons.person), text: 'NPCs'),
            Tab(icon: Icon(Icons.pin_drop), text: 'Locais'),
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
            PlayersList(), // Jogadores
            DiceRoller(),
            NPCs(
              npcsDoc: "aqWVN0TpUOmuK7M38onC",
            ),
            Locations(
              locationsDoc: "jU1gki9ds95lNPWgAwYT",
            ),
          ],
        ),
      ),
    );
  }
}
