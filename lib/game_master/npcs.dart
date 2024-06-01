import 'package:flutter/material.dart';

class NPCs extends StatefulWidget {
  const NPCs({super.key});

  @override
  State<NPCs> createState() => _NPCsState();
}

class _NPCsState extends State<NPCs> {
  final items = <NPC>[
    NPC(title: "Conselheiro do Rei", description: ""),
    NPC(title: "Guarda da Cidade 02", description: ""),
    NPC(title: "Médico Yueh", description: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => NPCModal(
            isEditing: false,
            onSave: (npc) {
              setState(() {
                items.add(npc);
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
              "NPCs",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) => NPCCard(
                  npc: items[index],
                  onSave: (npc) {
                    setState(() {
                      items[index] = npc;
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
            ),
          ],
        ),
      ),
    );
  }
}

class NPC {
  final String title;
  final String description;

  NPC({required this.title, required this.description});

  NPC clone() {
    return NPC(title: title, description: description);
  }
}

class NPCCard extends StatelessWidget {
  final NPC npc;
  final void Function(NPC) onSave;
  final void Function() onConfirmRemove;

  const NPCCard({
    super.key,
    required this.npc,
    required this.onSave,
    required this.onConfirmRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => NPCModal(
            isEditing: true,
            npc: npc,
            onSave: onSave,
          ),
        ),
        title: Text(npc.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => NPCModal(
                  isEditing: true,
                  npc: npc,
                  onSave: onSave,
                ),
              ),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDeleteDialog(
                  message: "Tem certeza que deseja remover esse personagem?",
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

class NPCModal extends StatefulWidget {
  final bool isEditing;
  final NPC? npc;
  final void Function(NPC) onSave;

  const NPCModal({
    super.key,
    required this.isEditing,
    this.npc,
    required this.onSave,
  });

  @override
  State<NPCModal> createState() => _NPCModalState();
}

class _NPCModalState extends State<NPCModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var npc = widget.npc?.clone() ?? NPC(title: "", description: "");
    titleController.text = npc.title;
    descriptionController.text = npc.description;
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
              widget.isEditing ? "Editar Personagem" : "Novo Personagem",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
                hintText: "Informe o nome do personagem",
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
                hintText: "Informe as observações do personagem",
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
                    NPC(
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
