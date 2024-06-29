import 'package:dice_keeper/models/character.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:flutter/material.dart';

class CardCharacter extends StatelessWidget {
  final Character character;
  final VoidCallback onPressedFunction;

  const CardCharacter({
    super.key,
    required this.character,
    required this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RoomRepository.get(character.roomId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            return Card(
              child: ListTile(
                onTap: onPressedFunction,
                title: Text(character.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.requireData.title),
                    Text(character.level.toString()),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
