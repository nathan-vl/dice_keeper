import 'package:dice_keeper/game_master/game_master_main.dart';
import 'package:flutter/material.dart';

class ListMaster extends StatelessWidget {
  const ListMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListMasterState();
  }
}

class CardRoom extends StatelessWidget {
  const CardRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardRoom();
  }
}

class _CardRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const GameMasterMain(roomName: "[Nome da Sala]"),
            ),
          );
        },
        leading: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              child: CircleAvatar(
                  backgroundImage: Image.asset("assets/splash_1152.png").image),
            );
          },
        ),
        title: const Text('Nome da Sala'),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tema do Jogo'),
            Text('Nome do Sistema'),
          ],
        ),
        trailing: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth * 0.25,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight,
                    child: CircleAvatar(
                        backgroundImage:
                            Image.asset("assets/splash_1152.png").image),
                  ),
                  Positioned(
                    left: 21,
                    child: Container(
                      height: constraints.maxHeight,
                      child: CircleAvatar(
                          backgroundImage:
                              Image.asset("assets/splash_1152.png").image),
                    ),
                  ),
                  Positioned(
                    left: 42,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "+4",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListMasterState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0), child: CardRoom()),
      ],
    );
  }
}
