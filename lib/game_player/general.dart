import 'package:flutter/material.dart';

class General extends StatefulWidget {
  const General({super.key});

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "[Nome do personagem]",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: TextField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome do Personagem',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'lvl',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: AttributeField(attribute: "Força"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: AttributeField(attribute: "Habilidade"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: AttributeField(attribute: "Resistência"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: AttributeField(attribute: "Armadura"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: AttributeField(attribute: "Poder de Fogo"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'PV',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'PM',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      maxLines: 16,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        labelText: 'História do Personagem',
                        hintText: "Digite a história do seu persongem...!",
                        hintStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}

class AttributeField extends StatefulWidget {
  const AttributeField({super.key, required this.attribute});
  final String attribute;

  @override
  State<AttributeField> createState() {
    return _AttributeField();
  }
}

class _AttributeField extends State<AttributeField> {
  late String title = '';

  @override
  void initState() {
    super.initState();
    title = widget.attribute;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: title,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: FilledButton(
                style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(15, 17, 15, 17)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ))),
                onPressed: () {},
                child: const Icon(Icons.add)),
          ),
        ),
        Expanded(
            flex: 1,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: FilledButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(15, 17, 15, 17)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ))),
                    onPressed: () {},
                    child: const Icon(Icons.remove)),
              ),
            )),
      ],
    );
  }
}
