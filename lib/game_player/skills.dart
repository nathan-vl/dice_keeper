import 'package:dice_keeper/models/skill.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/repository/skill_repository.dart';
import 'package:dice_keeper/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Skills extends StatefulWidget {
  final String characterId;

  const Skills({super.key, required this.characterId});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  var items = List.empty();
  List<Skill> filteredItems = <Skill>[];
  List<Skill> selectedItems = <Skill>[];

  @override
  void initState() {
    super.initState();
    SkillRepository.get().then((res) {
      CharactersRepository.get(widget.characterId).then((res2) {
        setState(() {
          items = res;
          selectedItems = res2!.skills;
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
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
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
                        (skill) => ListTile(
                          title: Text(skill.name),
                          onTap: () {
                            setState(
                              () {
                                controller.closeView("");
                                showDialog(
                                  context: context,
                                  builder: (context) => SkillModal(
                                    onSave: (skill) {
                                      selectedItems.add(skill);
                                      CharactersRepository.updateSkills(
                                        widget.characterId,
                                        selectedItems,
                                      ).then(
                                        (value) {
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    skill: skill,
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
                itemBuilder: (context, index) => SkillCard(
                  skill: selectedItems[index],
                  onSave: (skill) {
                    setState(() {
                      selectedItems[index] = skill;
                    });
                    Navigator.pop(context);
                  },
                  onConfirmRemove: () {
                    selectedItems.removeAt(index);
                    CharactersRepository.updateSkills(
                      widget.characterId,
                      selectedItems,
                    ).then(
                      (value) {
                        setState(() {});
                        Navigator.pop(context);
                      },
                    );
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
                builder: (context) => ConfirmDialog(
                  message: "Tem certeza que deseja remover essa habilidade?",
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
            Container(
              height: 200.0,
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.43),
              child: SingleChildScrollView(
                child: Center(child: Text(skill.description)),
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
