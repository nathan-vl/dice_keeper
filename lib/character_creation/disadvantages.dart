import 'package:dice_keeper/character_creation/inventory.dart';
import 'package:dice_keeper/models/disadvantage.dart';
import 'package:dice_keeper/repository/disadvantages_repository.dart';
import 'package:dice_keeper/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Disadvantages extends StatefulWidget {
  final Map<String, dynamic> currentCharacter;

  const Disadvantages({super.key, required this.currentCharacter});

  @override
  State<Disadvantages> createState() => _DisadvantagesState();
}

class _DisadvantagesState extends State<Disadvantages> {
  var items = List.empty();
  final selectedItems = <Disadvantage>[];
  List<Disadvantage> filteredItems = <Disadvantage>[];

  @override
  void initState() {
    super.initState();
    DisadvantagesRepository.get().then((res) {
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
              "Desvantagens",
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
                              (disadvantage) => ListTile(
                                title: Text(disadvantage.name),
                                onTap: () {
                                  setState(
                                    () {
                                      controller.closeView("");
                                      showDialog(
                                        context: context,
                                        builder: (context) => DisadvantageModal(
                                          onSave: (disadvantage) {
                                            setState(
                                              () {
                                                selectedItems.add(disadvantage);
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                          disadvantage: disadvantage,
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
                      itemBuilder: (context, index) => DisadvantageCard(
                        disadvantage: selectedItems[index],
                        onSave: (disadvantage) {
                          setState(() {
                            selectedItems[index] = disadvantage;
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
                                        character['disadvantages'] =
                                            selectedItems
                                                .map(
                                                  (item) => item.toMap(),
                                                )
                                                .toList();
                                        return Inventory(
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
                                  character['disadvantages'] = selectedItems
                                      .map(
                                        (item) => item.toMap(),
                                      )
                                      .toList();
                                  return Inventory(
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

class DisadvantageCard extends StatelessWidget {
  final Disadvantage disadvantage;
  final void Function(Disadvantage) onSave;
  final void Function() onConfirmRemove;

  const DisadvantageCard({
    super.key,
    required this.disadvantage,
    required this.onSave,
    required this.onConfirmRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => DisadvantageModal(
            disadvantage: disadvantage,
            onSave: onSave,
            isShowing: true,
          ),
        ),
        title: Text(disadvantage.name),
        subtitle: Text(
          disadvantage.description,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDialog(
                  message: "Tem certeza que deseja remover essa desvantagem?",
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

class DisadvantageModal extends StatefulWidget {
  final bool isShowing;
  final Disadvantage disadvantage;
  final void Function(Disadvantage) onSave;

  const DisadvantageModal({
    super.key,
    required this.disadvantage,
    required this.onSave,
    required this.isShowing,
  });

  @override
  State<DisadvantageModal> createState() => _DisadvantageModalState();
}

class _DisadvantageModalState extends State<DisadvantageModal> {
  Disadvantage disadvantage = Disadvantage(name: '', description: '');

  @override
  void initState() {
    super.initState();
    disadvantage = widget.disadvantage.clone();
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
              disadvantage.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.43),
              child: SingleChildScrollView(
                child: Text(disadvantage.description),
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
                          Disadvantage(
                            name: disadvantage.name,
                            description: disadvantage.description,
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
