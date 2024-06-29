import 'package:dice_keeper/character_creation/conclude.dart';
import 'package:dice_keeper/models/item.dart';
import 'package:dice_keeper/repository/item_repository.dart';
import 'package:dice_keeper/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  final Map<String, dynamic> currentCharacter;

  const Inventory({super.key, required this.currentCharacter});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  var items = List.empty();
  final selectedItems = <Item>[];
  List<Item> filteredItems = <Item>[];

  @override
  void initState() {
    super.initState();
    ItemRepository.get().then((res) {
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
              "Inventário",
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
                        onChanged: (_) {
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
                              (item) => ListTile(
                                title: Text(item.name),
                                onTap: () {
                                  setState(
                                    () {
                                      controller.closeView("");
                                      showDialog(
                                        context: context,
                                        builder: (context) => InventoryModal(
                                          onSave: (skill) {
                                            setState(
                                              () {
                                                selectedItems.add(skill);
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                          item: item,
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
                      itemBuilder: (context, index) => InventoryCard(
                        item: selectedItems[index],
                        onSave: (item) {
                          setState(() {
                            selectedItems[index] = item;
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
                                        character['inventory'] = selectedItems
                                            .map(
                                              (item) => item.toMap(),
                                            )
                                            .toList();
                                        return Conclude(
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
                                  character['inventory'] = selectedItems
                                      .map(
                                        (item) => item.toMap(),
                                      )
                                      .toList();
                                  return Conclude(
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

class InventoryCard extends StatelessWidget {
  final Item item;
  final void Function(Item) onSave;
  final void Function() onConfirmRemove;

  const InventoryCard({
    super.key,
    required this.item,
    required this.onSave,
    required this.onConfirmRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => InventoryModal(
            item: item,
            onSave: onSave,
            isShowing: true,
          ),
        ),
        title: Text(item.name),
        subtitle: Text(
          item.effect,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDialog(
                  message: "Tem certeza que deseja remover esse item?",
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

class InventoryModal extends StatefulWidget {
  final bool isShowing;
  final Item item;
  final void Function(Item) onSave;

  const InventoryModal({
    super.key,
    required this.item,
    required this.onSave,
    required this.isShowing,
  });

  @override
  State<InventoryModal> createState() => _InventoryModalState();
}

class _InventoryModalState extends State<InventoryModal> {
  Item item = Item(name: '', effect: '');

  @override
  void initState() {
    super.initState();
    item = widget.item.clone();
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
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(item.effect),
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
                          Item(
                            name: item.name,
                            effect: item.effect,
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
