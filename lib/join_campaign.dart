import 'package:flutter/material.dart';

class JoinCampaign extends StatefulWidget {
  const JoinCampaign({super.key});

  @override
  State<JoinCampaign> createState() => _JoinCampaignState();
}

class _JoinCampaignState extends State<JoinCampaign> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 151),
            child: const Text(
              'Entrar na Campanha',
              style: TextStyle(fontSize: 32),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: const Text(
              'Para entrar na sala de uma campanha, você pode digitar o código no campo abaixo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: const TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Código da Sala',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: const Text(
              'Ou',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 240),
            width: double.infinity,
            height: 56,
            child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                ),
                onPressed: () => {},
                child: const Text('Escanear QRCode')),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: const Text(
              'Voltar',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color.fromRGBO(74, 84, 140, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
