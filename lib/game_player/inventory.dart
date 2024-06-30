import 'package:dice_keeper/models/item.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/repository/item_repository.dart';
import 'package:dice_keeper/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  final String characterId;

  const Inventory({super.key, required this.characterId});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  var items = List.empty();
  List<Item> selectedItems = <Item>[];
  List<Item> filteredItems = <Item>[];

  @override
  void initState() {
    super.initState();
    ItemRepository.get().then((res) {
      CharactersRepository.get(widget.characterId).then((res2) {
        setState(() {
          items = res;
          selectedItems = res2!.inventory;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                            EdgeInsets.symmetric(horizontal: 16.0)),
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
                  const SizedBox(height: 16.0),
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
            Container(
              height: 200.0,
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.43),
              child: SingleChildScrollView(
                child: Center(child: Text(item.effect)),
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
