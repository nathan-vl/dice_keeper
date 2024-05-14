import 'package:flutter/material.dart';

class ListMaster extends StatelessWidget {
  const ListMaster({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _ListMasterState();
  }
}

class CardRoom extends StatelessWidget {
  const CardRoom({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _CardRoom();
  }
}

class _CardRoom extends StatelessWidget {
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {},
        leading: Image.asset("assets/splash_1152.png"),
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
                  Image.asset(
                    "assets/splash_1152.png",
                    height: constraints.maxHeight,
                  ),
                  Positioned(
                    left: 21,
                    child: Image.asset(
                      "assets/splash_1152.png",
                      height: constraints.maxHeight,
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
                        padding: EdgeInsets.all(8.0),
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
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: CardRoom()),
      ],
    );
  }
}
