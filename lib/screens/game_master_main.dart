import 'package:dice_keeper/dice_roller.dart';
import 'package:dice_keeper/screens/game_master_locations.dart';
import 'package:dice_keeper/screens/game_master_npcs.dart';
import 'package:dice_keeper/screens/game_master_players_list.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:flutter/material.dart';

class GameMasterMain extends StatefulWidget {
  final String roomDoc;

  const GameMasterMain({
    super.key,
    required this.roomDoc,
  });

  @override
  State<GameMasterMain> createState() => _GameMasterMainState();
}

class _GameMasterMainState extends State<GameMasterMain> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RoomRepository.get(widget.roomDoc),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Placeholder();
          case ConnectionState.done:
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
                  title: Text(snapshot.requireData.title),
                ),
                body: TabBarView(
                  children: [
                    const GameMasterPlayersList(), // Jogadores
                    const DiceRoller(),
                    GameMasterNPCs(
                      npcsDoc: snapshot.requireData.npcsRef.id,
                    ),
                    GameMasterLocations(
                      locationsDoc: snapshot.requireData.locationsRef.id,
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
