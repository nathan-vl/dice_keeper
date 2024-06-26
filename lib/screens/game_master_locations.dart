import 'package:dice_keeper/models/location.dart';
import 'package:dice_keeper/repository/location_repository.dart';
import 'package:dice_keeper/widgets/confirm_delete_dialog.dart';
import 'package:flutter/material.dart';

class GameMasterLocations extends StatefulWidget {
  final String locationsDoc;

  const GameMasterLocations({super.key, required this.locationsDoc});

  @override
  State<GameMasterLocations> createState() => _GameMasterLocationsState();
}

class _GameMasterLocationsState extends State<GameMasterLocations> {
  List<Location> items = List.empty();

  @override
  void initState() {
    super.initState();
    LocationRepository.get(widget.locationsDoc).then((res) {
      setState(() {
        items = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => LocationModal(
            isEditing: false,
            onSave: (location) {
              items.add(location);
              LocationRepository.update(widget.locationsDoc, items);

              setState(() {});
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
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) => LocationCard(
                  location: items[index],
                  onSave: (location) {
                    items[index] = location;
                    LocationRepository.update(widget.locationsDoc, items);

                    setState(() {});
                    Navigator.pop(context);
                  },
                  onConfirmRemove: () {
                    items.removeAt(index);
                    LocationRepository.update(widget.locationsDoc, items);

                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
