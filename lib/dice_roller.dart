import 'dart:math';

import 'package:dice_keeper/dice_parser.dart';
import 'package:dice_keeper/widgets/dice_button.dart';
import 'package:dice_keeper/widgets/unknown_dice_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      tokens.map((e) => e.toString()).toList().join(' '),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      (diceRolled == null)
                          ? ""
                          : "${diceRolled?.ast()} = ${diceRolled?.eval() ?? 0}",
                      style: const TextStyle(fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: GridView.count(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
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
        case Dice():
          tokens.add(Plus());
        case FateDice():
          tokens.add(Plus());
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
        case Dice():
          tokens.add(Plus());
        case FateDice():
          tokens.add(Plus());
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
        case Dice():
          tokens.add(Plus());
        case FateDice():
          tokens.add(Plus());
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

/*
buttons
: filter?
  drop|keep lowest|highest N
: exploding?
  [N times] always on M or less|more
*/
