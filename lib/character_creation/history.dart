import 'package:dice_keeper/character_creation/skills.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final Map<String, dynamic> currentCharacter;

  const History({super.key, required this.currentCharacter});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "História",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    maxLines: 15,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      labelText: 'História do Personagem',
                      hintText: "Digite a história do seu persongem...!",
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 140, 20, 0),
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              var character = widget.currentCharacter;
                              character['history'] = controller.text;
                              return Skills(currentCharacter: character);
                            },
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
      ),
    );
  }
}
