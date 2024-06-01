import 'package:dice_keeper/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final items = <Item>[
    Item(name: "Faca", description: "Uma faca tramontina."),
    Item(name: "Espada", description: "Uma espada de aço."),
    Item(name: "Arco", description: "Um arco de madeira reforçado."),
  ];
  final filteredItems = <Item>[];
  final selectedItems = <Item>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
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

class Item {
  final String name;
  final String description;

  Item({required this.name, required this.description});
  Item clone() {
    return Item(name: name, description: description);
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
          item.description,
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
  Item item = Item(name: '', description: '');

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
            Text(item.description),
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
                            description: item.description,
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
