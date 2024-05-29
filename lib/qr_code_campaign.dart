import 'package:dice_keeper/room_selection.dart';
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
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 30),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomSelection(),
                      ),
                    );
                  },
                  child: const Text('VISUALIZAR CAMPANHAS'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
