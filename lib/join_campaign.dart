import 'package:flutter/material.dart';

class JoinCampaign extends StatefulWidget {
  const JoinCampaign({super.key});

  @override
  State<JoinCampaign> createState() => _JoinCampaignState();
}

class _JoinCampaignState extends State<JoinCampaign> {
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 240),
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () => {},
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
