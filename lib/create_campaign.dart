import 'package:dice_keeper/qr_code_campaign.dart';
import 'package:flutter/material.dart';

class CreateCampaign extends StatefulWidget {
  const CreateCampaign({super.key});

  @override
  State<CreateCampaign> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
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
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome da Campanha',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade de Jogadores',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    const Text('Sala privada')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha da Sala',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QRCodeCampaign(),
                      ),
                    );
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
