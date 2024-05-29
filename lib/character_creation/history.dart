import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return _History();
  }
}

class _History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
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
                const TextField(
                  maxLines: 16,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    labelText: 'História do Personagem',
                    hintText: "Digite a história do seu persongem...!",
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 110, 20, 0),
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: () {},
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
