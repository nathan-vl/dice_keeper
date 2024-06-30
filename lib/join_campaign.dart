import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/character_creation/sheet.dart';
import 'package:dice_keeper/providers/UserProvider.dart';
import 'package:dice_keeper/repository/room_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinCampaign extends StatefulWidget {
  const JoinCampaign({super.key});

  @override
  State<JoinCampaign> createState() => _JoinCampaignState();
}

class _JoinCampaignState extends State<JoinCampaign> {
  final TextEditingController _tokenRoomController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> _hasCharacterInRoom(String userId, String token) async {
    try {
      QuerySnapshot querySnapshotRooms = await _firestore
        .collection('rooms')
        .where( 'token', isEqualTo: token )
        .get();

      if (querySnapshotRooms.docs.isNotEmpty) {
        for (var docRoom in querySnapshotRooms.docs) {
          QuerySnapshot querySnapshotCharacters = await _firestore
            .collection('characters')
            .where(
              Filter.and(
                Filter("roomId", isEqualTo: docRoom.id),
                Filter("playerId", isEqualTo: userId)
              )
            )
            .get();

          if ( querySnapshotCharacters.docs.isNotEmpty ) {
            return true;
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Falha ao tentar acessar dados do usuario.")),
      );
    }
    return false;
  }

  Future<bool> _limitHasBeenReached(String token) async {
    try {
      QuerySnapshot querySnapshotRooms = await _firestore
        .collection('rooms')
        .where( 'token', isEqualTo: token )
        .get();

      if (querySnapshotRooms.docs.isNotEmpty) {
        for (var docRoom in querySnapshotRooms.docs) {
          QuerySnapshot querySnapshotCharacters = await _firestore
            .collection('characters')
            .where("roomId", isEqualTo: docRoom.id)
            .get();

          if ( !querySnapshotCharacters.docs.isNotEmpty && querySnapshotCharacters.size >= int.parse(docRoom.get('playerQuantity')) ) {
            return true;
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Falha ao tentar acessar dados da sala.")),
      );
    }
    return false;
  }

  Future<void> _signInRoom(String userId) async {
    try {
      String token = _tokenRoomController.text;
      if (token.length == 7) {
        bool hasCharacterInRoom = await _hasCharacterInRoom(userId, token);
        if ( !hasCharacterInRoom ) {
          bool limitHasBeenReached = await _limitHasBeenReached(token);

          if (!limitHasBeenReached) {
            final room = await RoomRepository.findByToken(token);
            if (room != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sheet(room: room),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Esta campanha já atingiu o limite de jogadores.")),
            );
          }

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("O usuário já possui personagem nesta campanha.")),
          );
        }
      }
  } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Falha ao tentar acessar dados do usuario.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String uid = userProvider.uid;

    return Scaffold(
      body: Container(
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 100),
                child: Text(
                  'Entrar na Campanha',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Text(
                  'Para entrar na sala de uma campanha, você pode digitar o código no campo abaixo',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _tokenRoomController,
                  onChanged: (value) => _signInRoom(uid),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Código da Sala',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Text(
                  'Ou',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 240),
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Placeholder(),
                      ),
                    );
                  },
                  child: const Text('Escanear QRCode'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
