import 'package:flutter/material.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final items = <Location>[
    Location(title: "Vila Foosha", description: ""),
    Location(title: "Anor Londo", description: ""),
    Location(title: "Castelo do Rei", description: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => LocationModal(
            isEditing: false,
            onSave: (location) {
              setState(() {
                items.add(location);
              });
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Locais",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) => LocationCard(
                      location: items[index],
                      onSave: (location) {
                        setState(() {
                          items[index] = location;
                        });
                        Navigator.pop(context);
                      },
                      onConfirmRemove: () {
                        setState(() {
                          items.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
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

class Location {
  final String title;
  final String description;

  Location({required this.title, required this.description});

  Location clone() {
    return Location(title: title, description: description);
  }
}

class LocationCard extends StatelessWidget {
  final Location location;
  final void Function(Location) onSave;
  final void Function() onConfirmRemove;

  const LocationCard({
    super.key,
    required this.location,
    required this.onSave,
    required this.onConfirmRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => LocationModal(
            isEditing: true,
            location: location,
            onSave: onSave,
          ),
        ),
        title: Text(location.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => LocationModal(
                  isEditing: true,
                  location: location,
                  onSave: onSave,
                ),
              ),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDeleteDialog(
                  message: "Tem certeza que deseja remover esse local?",
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

class LocationModal extends StatefulWidget {
  final bool isEditing;
  final Location? location;
  final void Function(Location) onSave;

  const LocationModal({
    super.key,
    required this.isEditing,
    this.location,
    required this.onSave,
  });

  @override
  State<LocationModal> createState() => _LocationModalState();
}

class _LocationModalState extends State<LocationModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var location =
        widget.location?.clone() ?? Location(title: "", description: "");
    titleController.text = location.title;
    descriptionController.text = location.description;
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
              widget.isEditing ? "Editar Local" : "Novo Local",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
                hintText: "Informe o nome do local",
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Observações",
                border: OutlineInputBorder(),
                hintText: "Informe as observações do local",
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                FilledButton(
                  onPressed: () => widget.onSave(
                    Location(
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  ),
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmDeleteDialog extends StatelessWidget {
  final String message;
  final void Function() onConfirm;

  const ConfirmDeleteDialog(
      {super.key, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                OutlinedButton(
                  onPressed: onConfirm,
                  child: const Text("Remover"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
