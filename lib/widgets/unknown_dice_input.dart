import 'package:flutter/material.dart';

class UnknownDiceInput extends StatefulWidget {
  final TextStyle fontStyle;
  final void Function(int) onModalButtonPressed;

  const UnknownDiceInput({
    super.key,
    required this.fontStyle,
    required this.onModalButtonPressed,
  });

  @override
  State<UnknownDiceInput> createState() => _UnknownDiceInputState();
}

class _UnknownDiceInputState extends State<UnknownDiceInput> {
  final inputController = TextEditingController();
  int? diceQty;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () => {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Número de Faces",
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    onPressed: () {
                      if (inputController.text.toString().isNotEmpty) {
                        var faces = int.tryParse(inputController.value.text);
                        if ((faces ?? 0) > 0) {
                          widget.onModalButtonPressed(faces!);
                        }
                      }
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            ),
          ),
        )
      },
      child: Text("dN", style: widget.fontStyle),
    );
  }
}
