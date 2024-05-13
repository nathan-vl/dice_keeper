import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Card(
                    child: ListTile(
                      title: const Text('Nome do Personagem'),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('Nome da Sala'), Text('Lv 10')],
                      ),
                      trailing: Image.asset("assets/splash_1152.png"),
                    ),
                  ),
                )
              ],
            ),
            ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Card(
                    child: Expanded(
                      child: ListTile(
                        leading: Image.asset("assets/splash_1152.png"),
                        title: const Text('Nome da Sala'),
                        subtitle: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tema do Jogo'),
                            Text('Nome do Sistema')
                          ],
                        ),
                        trailing: Stack(
                          children: <Widget>[
                            Positioned(
                                child: Image.asset(
                              "assets/splash_1152.png",
                              height: 10,
                            )),
                            Positioned(
                                child: Image.asset("assets/splash_1152.png")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
      ),
    );
  }
}
