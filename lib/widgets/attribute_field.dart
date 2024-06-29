import 'package:flutter/material.dart';

class AttributeField extends StatefulWidget {
  final TextEditingController controller;
  final String attribute;
  final void Function(String)? onChanged;

  const AttributeField({
    super.key,
    required this.attribute,
    required this.controller,
    this.onChanged,
  });

  @override
  State<AttributeField> createState() {
    return _AttributeField();
  }
}

class _AttributeField extends State<AttributeField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.attribute,
            ),
            onChanged: widget.onChanged,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: FilledButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.fromLTRB(15, 17, 15, 17),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                if (widget.controller.text == "") {
                  widget.controller.text = '0';
                }
                int value = int.parse(widget.controller.text);
                widget.controller.text = (value += 1).toString();
              },
              child: const Icon(Icons.add),
            ),
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
                    const EdgeInsets.fromLTRB(15, 17, 15, 17),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (widget.controller.text == "") {
                    widget.controller.text = '0';
                  }
                  int value = int.parse(widget.controller.text);
                  if (value > 0) {
                    widget.controller.text = (value -= 1).toString();
                  }
                },
                child: const Icon(Icons.remove),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
