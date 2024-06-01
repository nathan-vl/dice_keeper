import 'package:flutter/material.dart';

class AttributeField extends StatefulWidget {
  const AttributeField({super.key, required this.attribute});
  final String attribute;

  @override
  State<AttributeField> createState() {
    return _AttributeField();
  }
}

class _AttributeField extends State<AttributeField> {
  final controller = TextEditingController();
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
            controller: controller,
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
                onPressed: () {
                  if (controller.text == "") {
                    controller.text = '0';
                  }
                  int value = int.parse(controller.text);
                  controller.text = (value += 1).toString();
                },
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
                    onPressed: () {
                      if (controller.text == "") {
                        controller.text = '0';
                      }
                      int value = int.parse(controller.text);
                      if (value > 0) {
                        controller.text = (value -= 1).toString();
                      }
                    },
                    child: const Icon(Icons.remove)),
              ),
            )),
      ],
    );
  }
}
