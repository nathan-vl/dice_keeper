import 'package:dice_keeper/character_creation/history.dart';
import 'package:dice_keeper/widgets/atribbute_field.dart';
import 'package:flutter/material.dart';

class Sheet extends StatelessWidget {
  const Sheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ficha do Personagem",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome do Personagem',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'lvl',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: AttributeField(attribute: "Força"),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: AttributeField(attribute: "Habilidade"),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: AttributeField(attribute: "Resistência"),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: AttributeField(attribute: "Armadura"),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: AttributeField(attribute: "Poder de Fogo"),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'PV',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'PM',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const History(),
                        ),
                      );
                    },
                    child: const Text('Prosseguir'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Voltar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
