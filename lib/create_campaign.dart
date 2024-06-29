import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dice_keeper/providers/UserProvider.dart';
import 'package:dice_keeper/qr_code_campaign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateCampaign extends StatefulWidget {
  const CreateCampaign({super.key});

  @override
  State<CreateCampaign> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
  final TextEditingController _campaignNameController = TextEditingController();
  final TextEditingController _playerQuantityController = TextEditingController();
  final TextEditingController _systemTypeController = TextEditingController(text: "3D&T");
  bool isPrivateRoom = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _generateToken() {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        7,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  void _submitForm(String userId) async {
      if ( _campaignNameController.text.isEmpty || _playerQuantityController.text.isEmpty || _systemTypeController.text.isEmpty ) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Todos os campos devem ser preenchidos!")),
        );
      } else {
        bool canSubmit = false;

        if ( isPrivateRoom ) {
          if ( _passwordController.text.isEmpty || _passwordController.text.isEmpty ) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Todos os campos devem ser preenchidos!")),
            );
          } else if ( _passwordController.text != _confirmPasswordController.text ) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Os campos de senha e confirmação da senha não batem!")),
            );
          } else {
            canSubmit = true;
          }
        } else {
          canSubmit = true;
        }

        if ( canSubmit ) {
          _generateRoom(userId);
        }
      }
  }

  void _generateRoom(String userId) async {
    try {
      var roomId = const Uuid().v4();
      String token = _generateToken();

      DocumentReference userReference = _firestore.collection('users').doc(userId);

      await _firestore.collection('rooms').doc(roomId).set({
        "gameMaster": userReference,
        "title": _campaignNameController.text,
        "password": !isPrivateRoom ? "" : md5.convert(utf8.encode(_passwordController.text)).toString(),
        "token": token,
        "playerQuantity": _playerQuantityController.text,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeCampaign(token: token),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Falha ao criar campanha, tente novamente em instantes.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String uid = userProvider.uid;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            mainAxisSize: MainAxisSize.max,
             children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                child: Text(
                  'Criação da Campanha',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _campaignNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome da Campanha',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _playerQuantityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade de Jogadores',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _systemTypeController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tipo de Sistema de RPG',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: AlignmentDirectional.topStart,
                child: Row(
                  children: [
                    Checkbox(
                      tristate: true,
                      value: isPrivateRoom,
                      onChanged: (bool? value) {
                        setState(() {
                          isPrivateRoom = value != null;
                        });
                        if (!(isPrivateRoom == true)) {
                          _passwordController.text = '';
                          _confirmPasswordController.text = '';
                        } 
                      },
                    ),
                    const Text('Sala privada')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  readOnly: !(isPrivateRoom == true),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha da Sala',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  readOnly: !(isPrivateRoom == true),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar senha',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    _submitForm(uid);
                  },
                  child: const Text('FINALIZAR CRIAÇÃO DA CAMPANHA'),
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
