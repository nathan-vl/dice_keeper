import 'package:flutter/material.dart';
import 'package:dice_keeper/list_master.dart';
import 'package:dice_keeper/list_player.dart';

class RoomSelection extends StatelessWidget {
  const RoomSelection({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _RoomSelection();
  }
}
class _RoomSelection extends StatelessWidget{
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Jogador"),
              Tab(text: "Mestre"),
            ],
          ),
          title: const Text('O que vai ser hoje?'),
        ),
        body: const TabBarView(
          children: [
            ListPlayer(),
            ListMaster()
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
      ),
    );
  }
}
