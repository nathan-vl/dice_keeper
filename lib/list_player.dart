import 'package:dice_keeper/join_campaign.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListPlayer extends StatelessWidget {
  const ListPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListPlayerState();
  }
}

class _ListPlayerState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CardCharacter())
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
          child: const Icon(Icons.add)),
    );
  }
}

class CardCharacter extends StatelessWidget {
  const CardCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardCharacter();
  }
}

class _CardCharacter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: const Text('Nome do Personagem'),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome da Sala'),
            Text('Lv 10'),
          ],
        ),
        trailing: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: CircleAvatar(
                backgroundImage: Image.asset("assets/splash_1152.png").image),
          );
        }),
      ),
    );
  }
}
