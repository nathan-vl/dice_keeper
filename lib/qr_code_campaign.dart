import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeCampaign extends StatefulWidget {
  const QRCodeCampaign({super.key});

  @override
  State<QRCodeCampaign> createState() => _QRCodeCampaignState();
}

class _QRCodeCampaignState extends State<QRCodeCampaign> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
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
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Text(
              '2b0af0p',
              style: GoogleFonts.getFont(
                'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 57,
                height: 1.3,
                color: const Color.fromRGBO(42, 21, 89, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: QrImageView(
              data: "2B0AF0P",
              size: 250,
              // You can include embeddedImageStyle Property if you
              //wanna embed an image from your Asset folder
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(
                  100,
                  100,
                ),
              ),
            ),
          ),
          Container(
            width: 230,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Text(
              'Copiar código para a área de transferência',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Roboto',
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.2,
                color: const Color.fromRGBO(74, 84, 140, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: double.infinity,
            height: 56,
            child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                ),
                onPressed: () => {},
                child: const Text('VISUALIZAR CAMPANHAS')),
          ),
        ],
      ),
    );
  }
}
