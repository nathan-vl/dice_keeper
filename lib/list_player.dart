import 'package:dice_keeper/join_campaign.dart';
import 'package:dice_keeper/widgets/card_character.dart';
import 'package:flutter/material.dart';

class ListPlayer extends StatelessWidget {
  const ListPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: CardCharacter(
              title: "Nome do personagem",
              sub1: "Nome da sala",
              sub2: "lv: 10",
              image: "assets/splash_1152.png",
            ),
          )
        ],
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
