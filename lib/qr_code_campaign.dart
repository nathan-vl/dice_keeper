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
            child: Text(
              'Criação da Campanha',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Text(
              '2b0af0p',
              style: Theme.of(context).textTheme.displayLarge,
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
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Copiar código para a área de transferência',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () => {},
              child: const Text('VISUALIZAR CAMPANHAS'),
            ),
          ),
        ],
      ),
    );
  }
}
