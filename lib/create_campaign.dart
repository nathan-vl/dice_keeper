import 'package:flutter/material.dart';

class CreateCampaign extends StatefulWidget {
  const CreateCampaign({super.key});

  @override
  State<CreateCampaign> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: const Text(
              'Criação da Campanha',
              style: TextStyle(
                fontSize: 32,
              ),
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
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                ),
                onPressed: () => {},
                child: const Text('FINALIZAR CRIAÇÃO DA CAMPANHA')),
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
