import 'package:dice_keeper/game_player/player_main.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/widgets/card_character.dart';
import 'package:flutter/material.dart';

class GameMasterPlayersList extends StatefulWidget {
  final String roomId;
  const GameMasterPlayersList({super.key, required this.roomId});

  @override
  State<GameMasterPlayersList> createState() => _GameMasterPlayersListState();
}

class _GameMasterPlayersListState extends State<GameMasterPlayersList> {
  List<String> items = List.empty();

  @override
  void initState() {
    super.initState();
    CharactersRepository.getIdsByRoom(widget.roomId).then(
      (res) {
        setState(
          () {
            items = res;
          },
        );
      },
    );
  }

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
            child: Scaffold(
              body: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CardCharacter(
                    characterId: items[index],
                    onPressedFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayerMain(characterId: items[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
