import 'package:dice_keeper/create_campaign.dart';
import 'package:dice_keeper/models/room.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:dice_keeper/widgets/card_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListMaster extends StatefulWidget {
  const ListMaster({super.key});

  @override
  State<ListMaster> createState() => _ListMasterState();
}

class _ListMasterState extends State<ListMaster> {
  List<Room> items = <Room>[];

  @override
  void initState() {
    super.initState();
    RoomRepository.getByMaster(FirebaseAuth.instance.currentUser!.uid)
        .then((res) {
      setState(() {
        items = res;
      });
    });
  }

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
