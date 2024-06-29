import 'package:dice_keeper/join_campaign.dart';
import 'package:dice_keeper/models/character.dart';
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
  List<Character> items = <Character>[];

  @override
  void initState() {
    super.initState();
    CharactersRepository.getByPlayer(FirebaseAuth.instance.currentUser!.uid).then((res) {
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
        itemBuilder: (context, index) => CardCharacter(
          title: items[index].name,
          sub1: "Nome da sala",
          sub2: "lv: 10",
          image: "assets/splash_1152.png",
          onPressedFunction: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const PlayerMain(roomName: "[Nome da Sala]"),
              ),
            );
          },
        ),
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
