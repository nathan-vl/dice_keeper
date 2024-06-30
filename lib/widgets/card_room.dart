import 'package:dice_keeper/models/room.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:dice_keeper/screens/game_master_main.dart';
import 'package:flutter/material.dart';

class CardRoom extends StatefulWidget {
  final String roomId;
  const CardRoom({super.key, required this.roomId});

  @override
  State<CardRoom> createState() => _CardRoomState();
}

class _CardRoomState extends State<CardRoom> {
  Room? room;


  Future<void> _fetchData() async {
    room = await RoomRepository.get(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            return Card(
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameMasterMain(
                        roomDoc: widget.roomId,
                      ),
                    ),
                  );
                },
                leading: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: CircleAvatar(
                        backgroundImage:
                            Image.asset("assets/splash_1152.png").image,
                      ),
                    );
                  },
                ),
                title: Text(room!.title),
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
                          SizedBox(
                            height: constraints.maxHeight,
                            child: CircleAvatar(
                              backgroundImage:
                                  Image.asset("assets/splash_1152.png").image,
                            ),
                          ),
                          Positioned(
                            left: 21,
                            child: SizedBox(
                              height: constraints.maxHeight,
                              child: CircleAvatar(
                                backgroundImage:
                                    Image.asset("assets/splash_1152.png").image,
                              ),
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
      },
    );
  }
}
