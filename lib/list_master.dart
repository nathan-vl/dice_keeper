import 'package:dice_keeper/create_campaign.dart';
import 'package:dice_keeper/widgets/card_room.dart';
import 'package:flutter/material.dart';

class ListMaster extends StatelessWidget {
  const ListMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: CardRoom(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCampaign(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
