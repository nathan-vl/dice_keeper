import 'package:flutter/material.dart';
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
            child: const Text(
              'Criação da Campanha',
              style: TextStyle(fontSize: 32),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: const Text(
              '2b0af0p',
              style: TextStyle(
                fontSize: 57,
                color: Color.fromRGBO(42, 21, 89, 1),
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
            child: const Text(
              'Copiar código para a área de transferência',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color.fromRGBO(74, 84, 140, 1),
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
