import 'package:dice_keeper/models/character.dart';
import 'package:dice_keeper/repository/characters_repository.dart';
import 'package:dice_keeper/widgets/attribute_field.dart';
import 'package:flutter/material.dart';

class General extends StatelessWidget {
  final String characterId;
  const General({super.key, required this.characterId});

  Future<Character> _fetchData() async {
    return (await CharactersRepository.get(characterId))!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Placeholder();
          case ConnectionState.done:
            var character = snapshot.requireData;

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 24.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 10),
                          child: Text(
                            character.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: TextFormField(
                                    initialValue: character.name,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nome do Personagem',
                                    ),
                                    onChanged: (value) {
                                      character.name = value;
                                      CharactersRepository.update(
                                        characterId,
                                        character,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: TextFormField(
                                      initialValue: character.level.toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'lvl',
                                      ),
                                      onChanged: (value) {
                                        final level = int.tryParse(value);
                                        if (level != null) {
                                          character.level = level;
                                          CharactersRepository.update(
                                            characterId,
                                            character,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: AttributeField(
                                attribute: "Força",
                                controller: TextEditingController(
                                  text: character.str.toString(),
                                ),
                                onChanged: (value) {
                                  final n = int.tryParse(value);
                                  if (n != null) {
                                    character.str = n;
                                    CharactersRepository.update(
                                      characterId,
                                      character,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: AttributeField(
                                attribute: "Habilidade",
                                controller: TextEditingController(
                                  text: character.abi.toString(),
                                ),
                                onChanged: (value) {
                                  final n = int.tryParse(value);
                                  if (n != null) {
                                    character.abi = n;
                                    CharactersRepository.update(
                                      characterId,
                                      character,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: AttributeField(
                                attribute: "Resistência",
                                controller: TextEditingController(
                                  text: character.res.toString(),
                                ),
                                onChanged: (value) {
                                  final n = int.tryParse(value);
                                  if (n != null) {
                                    character.res = n;
                                    CharactersRepository.update(
                                      characterId,
                                      character,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: AttributeField(
                                attribute: "Armadura",
                                controller: TextEditingController(
                                  text: character.arm.toString(),
                                ),
                                onChanged: (value) {
                                  final n = int.tryParse(value);
                                  if (n != null) {
                                    character.arm = n;
                                    CharactersRepository.update(
                                      characterId,
                                      character,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: AttributeField(
                                attribute: "Poder de Fogo",
                                controller: TextEditingController(
                                  text: character.pof.toString(),
                                ),
                                onChanged: (value) {
                                  final n = int.tryParse(value);
                                  if (n != null) {
                                    character.pof = n;
                                    CharactersRepository.update(
                                      characterId,
                                      character,
                                    );
                                  }
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                    child: TextFormField(
                                      initialValue: character.hp.toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'PV',
                                      ),
                                      onChanged: (value) {
                                        final n = int.tryParse(value);
                                        if (n != null) {
                                          character.hp = n;
                                          CharactersRepository.update(
                                            characterId,
                                            character,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                    child: TextFormField(
                                      initialValue: character.mp.toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'PM',
                                      ),
                                      onChanged: (value) {
                                        final n = int.tryParse(value);
                                        if (n != null) {
                                          character.mp = n;
                                          CharactersRepository.update(
                                            characterId,
                                            character,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: character.history,
                              maxLines: 15,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: 'História do Personagem',
                                hintText:
                                    "Digite a história do seu persongem...!",
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              onChanged: (value) {
                                character.history = value;
                                CharactersRepository.update(
                                  characterId,
                                  character,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
