import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/character_creation/sheet.dart';
import 'package:flutter/material.dart';

class JoinCampaign extends StatefulWidget {
  const JoinCampaign({super.key});

  @override
  State<JoinCampaign> createState() => _JoinCampaignState();
}

class _JoinCampaignState extends State<JoinCampaign> {
  final TextEditingController _tokenRoomController = TextEditingController();
  CollectionReference tokens = FirebaseFirestore.instance.collection('tokens');

  Future<void> _signInRoom() async {
    String tokenRoom = _tokenRoomController.text;

    print("toke room: "+tokenRoom);

    if (tokenRoom.length == 7) {
      tokens
        .where('token', isEqualTo: tokenRoom)
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) {
            // Token encontrado dentro do período de tempo
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Sheet()),
            );
          } else {
            // Nenhum token encontrado ou fora do período de tempo
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Token inválido ou expirado')),
            );
          }
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao buscar token: $error')),
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (value) => _signInRoom(),
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
                        builder: (context) => const Sheet(),
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
