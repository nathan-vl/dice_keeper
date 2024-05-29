import 'package:flutter/material.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlayersListState();
  }
}

class _PlayersListState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Jogadores",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16.0),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CardPlayer(), CardPlayer()],
            ),
          ),
        ],
      ),
    );
  }
}

class CardPlayer extends StatelessWidget {
  const CardPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardPlayer();
  }
}

class _CardPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: const Text('Nome do Jogador'),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome do personagem'),
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
