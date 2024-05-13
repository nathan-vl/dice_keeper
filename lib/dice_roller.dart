import 'dart:math';

import 'package:dice_keeper/dice_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiceButton extends StatelessWidget {
  final void Function() onPressed;
  final String path;

  const DiceButton({
    super.key,
    required this.onPressed,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      child: SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(
          Theme.of(context).primaryColor,
          BlendMode.srcIn,
        ),
        height: 42,
      ),
    );
  }
}

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  List<Token> tokens = [];

  Expr? diceRolled;

  @override
  Widget build(BuildContext context) {
    const fontStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tokens.map((e) => e.toString()).toList().join(' '),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  (diceRolled != null)
                      ? Text(
                          "${diceRolled?.ast()} = ${diceRolled?.eval() ?? 0}",
                          style: const TextStyle(fontSize: 24))
                      : const Text(""),
                ],
              ),
            ),
            GridView.count(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                ...[2, 4, 6, 8, 10, 12, 20].map(
                  (i) => DiceButton(
                    onPressed: () => addCommonDice(i),
                    path: "./assets/dice/d$i.svg",
                  ),
                ),
                FilledButton.tonal(
                  onPressed: addD100,
                  child: const Text("d%", style: fontStyle),
                ),
                FilledButton.tonal(
                  onPressed: addFateDice,
                  child: const Text("dF", style: fontStyle),
                ),
                UnknownDiceInput(
                  fontStyle: fontStyle,
                  onModalButtonPressed: addCommonDice,
                ),
                FilledButton.tonal(
                  onPressed: addParenthesis,
                  child: const Text("( )", style: fontStyle),
                ),
                FilledButton(
                  onPressed: () => addToken(Slash()),
                  child: Transform.rotate(
                    angle: 45 * pi / 180,
                    child: const Icon(Icons.percent),
                  ),
                ),
                ...List.generate(
                  3,
                  (index) => FilledButton.tonal(
                    onPressed: () => addDigit(index + 7),
                    child: Text((index + 7).toString(), style: fontStyle),
                  ),
                ),
                FilledButton(
                  onPressed: () => addToken(Asterisk()),
                  child: Transform.rotate(
                    angle: 45 * pi / 180,
                    child: const Icon(Icons.add),
                  ),
                ),
                ...List.generate(
                  3,
                  (index) => FilledButton.tonal(
                    onPressed: () => addDigit(index + 4),
                    child: Text((index + 4).toString(), style: fontStyle),
                  ),
                ),
                FilledButton(
                  onPressed: () => addToken(Minus()),
                  child: const Icon(Icons.remove),
                ),
                ...List.generate(
                  3,
                  (index) => FilledButton.tonal(
                    onPressed: () => addDigit(index + 1),
                    child: Text((index + 1).toString(), style: fontStyle),
                  ),
                ),
                FilledButton(
                  onPressed: () => addToken(Plus()),
                  child: const Icon(Icons.add),
                ),
                FilledButton.tonal(
                  onPressed: () => addDigit(0),
                  child: const Text("0", style: fontStyle),
                ),
                FilledButton(
                  onPressed: () => setState(() {
                    tokens.clear();
                    diceRolled = null;
                  }),
                  child: const Text("AC", style: fontStyle),
                ),
                FilledButton(
                  onPressed: remove,
                  child: const Icon(Icons.backspace),
                ),
                FilledButton(
                  onPressed: () {
                    if (tokens.isNotEmpty) {
                      setState(() {
                        var parser = Parser(tokens);
                        try {
                          var ast = parser.buildAst();
                          diceRolled = ast?.rollDice();
                        } catch (e) {
                          diceRolled = null;
                        }
                      });
                    }
                  },
                  child: SvgPicture.asset(
                    "./assets/math/equal.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).canvasColor, BlendMode.srcIn),
                    height: 24.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addCommonDice(int faces) {
    var diceQty = 1;

    if (tokens.isNotEmpty) {
      var lastToken = tokens.last;
      switch (lastToken) {
        case Literal():
          diceQty = lastToken.value;
          tokens.removeLast();
        default:
          break;
      }
    }

    addToken(Dice(
      diceQty: diceQty,
      faces: List.generate(faces, (index) => index + 1),
      display: "${diceQty}d$faces",
    ));
  }

  void addD100() {
    var diceQty = 1;

    if (tokens.isNotEmpty) {
      var lastToken = tokens.last;
      switch (lastToken) {
        case Literal():
          diceQty = lastToken.value;
          tokens.removeLast();
        default:
          break;
      }
    }

    addToken(Dice(
      diceQty: diceQty,
      faces: List.generate(100, (index) => index + 1),
      display: "${diceQty}d%",
    ));
  }

  void addFateDice() {
    var diceQty = 1;

    if (tokens.isNotEmpty) {
      var lastToken = tokens.last;
      switch (lastToken) {
        case Literal():
          diceQty = lastToken.value;
          tokens.removeLast();
        default:
          break;
      }
    }

    addToken(FateDice(diceQty));
  }

  void addDigit(int number) {
    if (tokens.isNotEmpty) {
      var lastToken = tokens.last;
      switch (lastToken) {
        case Literal():
          var value = lastToken.value;
          tokens.removeLast();
          addToken(Literal(value * 10 + number));
        default:
          addToken(Literal(number));
      }
    } else {
      addToken(Literal(number));
    }
  }

  void remove() {
    if (tokens.isNotEmpty) {
      if (tokens.length == 1) {
        diceRolled = null;
      }

      var lastToken = tokens.last;

      setState(() {
        tokens.removeLast();
      });

      switch (lastToken) {
        case Literal():
          if (lastToken.value >= 10) {
            addToken(Literal((lastToken.value / 10).floor()));
          }
        default:
          break;
      }
    }
  }

  void addParenthesis() {
    var leftParen = true;

    var lCount = tokens.whereType<LeftParen>().length;
    var rCount = tokens.whereType<RightParen>().length;

    if (tokens.isNotEmpty) {
      var last = tokens.last;
      if (last case RightParen()) {
        leftParen = lCount <= rCount;
      }
      if (last case Literal() || Dice()) {
        leftParen = false;
      } else if (last
          case Plus() || Minus() || Asterisk() || Slash() || LeftParen()) {
        leftParen = true;
      }
    }

    if (leftParen) {
      addToken(LeftParen());
    } else {
      addToken(RightParen());
    }
  }

  void addToken(Token token) {
    setState(() {
      tokens.add(token);
    });
  }
}

class UnknownDiceInput extends StatefulWidget {
  final TextStyle fontStyle;
  final void Function(int) onModalButtonPressed;

  const UnknownDiceInput({
    super.key,
    required this.fontStyle,
    required this.onModalButtonPressed,
  });

  @override
  State<UnknownDiceInput> createState() => _UnknownDiceInputState();
}

class _UnknownDiceInputState extends State<UnknownDiceInput> {
  final inputController = TextEditingController();
  int? diceQty;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () => {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Número de Faces",
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    onPressed: () {
                      if (inputController.text.toString().isNotEmpty) {
                        var faces = int.tryParse(inputController.value.text);
                        if ((faces ?? 0) > 0) {
                          widget.onModalButtonPressed(faces!);
                        }
                      }
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            ),
          ),
        )
      },
      child: Text("dN", style: widget.fontStyle),
    );
  }
}

/*
buttons
: filter?
  drop|keep lowest|highest N
: exploding?
  [N times] always on M or less|more
*/
