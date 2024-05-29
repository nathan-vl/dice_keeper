import 'package:dice_keeper/character_creation/inventory.dart';
import 'package:flutter/material.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final items = <Skill>[
    Skill(name: "Bola de fogo", description: "uma bola de fogo."),
    Skill(name: "Bola de gelo", description: "uma bola de neve giganstruosa."),
    Skill(
        name: "Bola elétrica",
        description: "uma bola de raios feitos pelo deus grego Nathanzinho."),
  ];
  final selectedItems = <Skill>[];
  List<Skill> filteredItems = <Skill>[];

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
              "Habilidades",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchAnchor(builder:
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
                  }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(items.length, (int index) {
                      Skill skill = items[index];
                      return ListTile(
                        title: Text(skill.name),
                        onTap: () {
                          setState(() {
                            controller.closeView("");
                            showDialog(
                              context: context,
                              builder: (context) => SkillModal(
                                onSave: (skill) {
                                  setState(() {
                                    selectedItems.add(skill);
                                  });
                                  Navigator.pop(context);
                                },
                                skill: skill,
                                isShowing: false,
                              ),
                            );
                          });
                        },
                      );
                    });
                  }),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) => SkillCard(
                        skill: selectedItems[index],
                        onSave: (skill) {
                          setState(() {
                            selectedItems[index] = skill;
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Inventory(),
                          ),
                        );
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

class Skill {
  final String name;
  final String description;

  Skill({required this.name, required this.description});
  Skill clone() {
    return Skill(name: name, description: description);
  }
}

class SkillCard extends StatelessWidget {
  final Skill skill;
  final void Function(Skill) onSave;
  final void Function() onConfirmRemove;

  const SkillCard({
    super.key,
    required this.skill,
    required this.onSave,
    required this.onConfirmRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => SkillModal(
            skill: skill,
            onSave: onSave,
            isShowing: true,
          ),
        ),
        title: Text(skill.name),
        subtitle: Text(
          skill.description,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDeleteDialog(
                  message: "Tem certeza que deseja remover essa habilidade?",
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

class SkillModal extends StatefulWidget {
  final bool isShowing;
  final Skill skill;
  final void Function(Skill) onSave;

  const SkillModal({
    super.key,
    required this.skill,
    required this.onSave,
    required this.isShowing,
  });

  @override
  State<SkillModal> createState() => _SkillModalState();
}

class _SkillModalState extends State<SkillModal> {
  Skill skill = Skill(name: '', description: '');

  @override
  void initState() {
    super.initState();
    skill = widget.skill.clone();
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
              skill.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(skill.description),
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
                          Skill(
                            name: skill.name,
                            description: skill.description,
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
