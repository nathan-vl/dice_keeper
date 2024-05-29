import 'package:flutter/material.dart';
import 'package:dice_keeper/list_master.dart';
import 'package:dice_keeper/list_player.dart';

class RoomSelection extends StatelessWidget {
  const RoomSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return _RoomSelection();
  }
}

class _RoomSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('./assets/background.png'),
            fit: BoxFit.scaleDown,
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.05),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: DefaultTabController(
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
              children: [ListPlayer(), ListMaster()],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {}, child: const Icon(Icons.add)),
          ),
        ),
        // child: QRCodeCampaign(),
      ),
    );
  }
}
