import 'package:dice_keeper/game_player/general.dart';
import 'package:dice_keeper/game_player/inventory.dart';
import 'package:dice_keeper/game_player/skills.dart';
import 'package:flutter/material.dart';

class CharacterSheet extends StatefulWidget {
  const CharacterSheet({super.key});

  @override
  State<CharacterSheet> createState() => _CharacterSheetState();
}

class _CharacterSheetState extends State<CharacterSheet> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: "Geral"),
                  Tab(text: "Habilidades"),
                  Tab(text: "Inventário"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [General(), Skills(), Inventory()],
                ),
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () {}, child: const Icon(Icons.add)),
        ),
      ),
      // child: QRCodeCampaign(),
    );
  }
}
