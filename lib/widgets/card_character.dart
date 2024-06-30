import 'package:dice_keeper/models/character.dart';
import 'package:dice_keeper/models/room.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:flutter/material.dart';

class CardCharacter extends StatefulWidget {
  final String characterId;
  final VoidCallback onPressedFunction;

  const CardCharacter({
    super.key,
    required this.characterId,
    required this.onPressedFunction,
  });

  @override
  State<CardCharacter> createState() => _CardCharacterState();
}

class _CardCharacterState extends State<CardCharacter> {
  Character? character;
  Room? room;

  Future<void> _fetchData() async {
    character = await CharactersRepository.get(widget.characterId);
    room = await RoomRepository.get(character!.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            return Card(
              child: ListTile(
                onTap: widget.onPressedFunction,
                title: Text(character!.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(room!.title),
                    Text("level: ${character!.level}"),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
