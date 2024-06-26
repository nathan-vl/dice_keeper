import 'package:dice_keeper/join_campaign.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/widgets/card_character.dart';
import 'package:dice_keeper/game_player/player_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListPlayer extends StatefulWidget {
  const ListPlayer({super.key});

  @override
  State<ListPlayer> createState() => _ListPlayerState();
}

class _ListPlayerState extends State<ListPlayer> {
  List<String> items = List.empty();

  @override
  void initState() {
    super.initState();
    CharactersRepository.getIdsByPlayer(FirebaseAuth.instance.currentUser!.uid)
        .then((res) {
      setState(() {
        items = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  builder: (context) => PlayerMain(characterId: items[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const JoinCampaign(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
