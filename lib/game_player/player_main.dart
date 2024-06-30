import 'package:dice_keeper/dice_roller.dart';
import 'package:dice_keeper/game_player/character_sheet.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:flutter/material.dart';

class PlayerMain extends StatefulWidget {
  final String characterId;

  const PlayerMain({
    super.key,
    required this.characterId,
  });

  @override
  State<PlayerMain> createState() => _PlayerMainState();
}

class _PlayerMainState extends State<PlayerMain> {
  String roomName = "Sala";

  @override
  void initState() {
    super.initState();
    CharactersRepository.get(widget.characterId).then((res) {
      if (res != null) {
        RoomRepository.get(res.roomId).then((room) {
          setState(() {
            roomName = room.title;
          });
        });
      }
    });
  }

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
        body: TabBarView(
          children: [
            CharacterSheet(characterId: widget.characterId),
            const DiceRoller(),
          ],
        ),
      ),
    );
  }
}
