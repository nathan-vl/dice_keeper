import 'package:dice_keeper/character_creation/disadvantages.dart';
import 'package:dice_keeper/models/advantage.dart';
import 'package:dice_keeper/repository/advantages_repository.dart';
import 'package:dice_keeper/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Advantages extends StatefulWidget {
  final Map<String, dynamic> currentCharacter;

  const Advantages({super.key, required this.currentCharacter});

  @override
  State<Advantages> createState() => _AdvantagesState();
}

class _AdvantagesState extends State<Advantages> {
  var items = List.empty();
  final selectedItems = <Advantage>[];
  List<Advantage> filteredItems = <Advantage>[];

  @override
  void initState() {
    super.initState();
    AdvantagesRepository.get().then((res) {
      setState(() {
        items = res;
      });
    });
  }

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
              "Vantagens",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchAnchor(
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        controller: controller,
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (text) {
                          controller.openView();
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder: (
                      BuildContext context,
                      SearchController controller,
                    ) =>
                        items
                            .where((i) =>
                                controller.text.isEmpty ||
                                i.name
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()))
                            .map(
                              (advantage) => ListTile(
                                title: Text(advantage.name),
                                onTap: () {
                                  setState(
                                    () {
                                      controller.closeView("");
                                      showDialog(
                                        context: context,
                                        builder: (context) => AdvantageModal(
                                          onSave: (advantage) {
                                            setState(
                                              () {
                                                selectedItems.add(advantage);
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                          advantage: advantage,
                                          isShowing: false,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) => AdvantageCard(
                        advantage: selectedItems[index],
                        onSave: (advantage) {
                          setState(() {
                            selectedItems[index] = advantage;
                          });
                          Navigator.pop(context);
                        },
                        onConfirmRemove: () {
                          setState(() {
                            selectedItems.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () => {
                        if (selectedItems.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmDialog(
                                message: "Deseja continuar?",
                                confirmText: "Continuar",
                                onConfirm: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        var character = widget.currentCharacter;
                                        character['advantages'] = selectedItems
                                            .map(
                                              (item) => item.toMap(),
                                            )
                                            .toList();
                                        return Disadvantages(
                                          currentCharacter: character,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          }
                        else
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  var character = widget.currentCharacter;
                                  character['advantages'] = selectedItems
                                      .map(
                                        (item) => item.toMap(),
                                      )
                                      .toList();
                                  return Disadvantages(
                                    currentCharacter: character,
                                  );
                                },
                              ),
                            )
                          }
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
            ),
          ],
        ),
      ),
    );
  }
}

class AdvantageCard extends StatelessWidget {
  final Advantage advantage;
  final void Function(Advantage) onSave;
  final void Function() onConfirmRemove;

  const AdvantageCard({
    super.key,
    required this.advantage,
    required this.onSave,
    required this.onConfirmRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => AdvantageModal(
            advantage: advantage,
            onSave: onSave,
            isShowing: true,
          ),
        ),
        title: Text(advantage.name),
        subtitle: Text(
          advantage.description,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDialog(
                  message: "Tem certeza que deseja remover essa vantagem?",
                  confirmText: "Remover",
                  onConfirm: onConfirmRemove,
                ),
              ),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvantageModal extends StatefulWidget {
  final bool isShowing;
  final Advantage advantage;
  final void Function(Advantage) onSave;

  const AdvantageModal({
    super.key,
    required this.advantage,
    required this.onSave,
    required this.isShowing,
  });

  @override
  State<AdvantageModal> createState() => _AdvantageModalState();
}

class _AdvantageModalState extends State<AdvantageModal> {
  Advantage advantage = Advantage(name: '', description: '');

  @override
  void initState() {
    super.initState();
    advantage = widget.advantage.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              advantage.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.43),
              child: SingleChildScrollView(
                child: Text(advantage.description),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: widget.isShowing
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: widget.isShowing
                  ? [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("voltar"),
                      ),
                    ]
                  : [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                      FilledButton(
                        onPressed: () => widget.onSave(
                          Advantage(
                            name: advantage.name,
                            description: advantage.description,
                          ),
                        ),
                        child: const Text("Adicionar"),
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
