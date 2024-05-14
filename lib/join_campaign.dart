import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: Text(
              'Entrar na Campanha',
              style: GoogleFonts.getFont(
                'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 32,
                height: 1.3,
                color: const Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: Text(
              'Para entrar na sala de uma campanha, você pode digitar o código no campo abaixo',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.2,
                color: const Color.fromRGBO(0, 0, 0, 1),
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
            child: Text(
              'Ou',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.2,
                color: const Color.fromRGBO(0, 0, 0, 1),
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
            child: Text(
              'Voltar',
              style: GoogleFonts.getFont(
                'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.2,
                color: const Color.fromRGBO(74, 84, 140, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
