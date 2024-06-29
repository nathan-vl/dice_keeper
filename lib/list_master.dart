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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) => CardRoom(room: items[index]),
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
