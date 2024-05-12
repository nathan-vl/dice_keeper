import 'dart:math';

class Parser {
  List<Token> _tokens = [];

  Parser(List<Token> tokens) {
    _tokens = List.from(tokens);
  }

  Expr? buildAst() {
    if (_tokens.isEmpty) {
      return null;
    }

    var expr = _term();
    if (_tokens.isNotEmpty) {
      return null;
    }
    return expr;
  }

  Expr _term() {
    var expr = _factor();
    switch (_peek()) {
      case Plus():
        _next();
        var right = _term();
        return BinaryOperator(operator: Plus(), left: expr, right: right);
      case Minus():
        _next();
        var right = _term();
        return BinaryOperator(operator: Minus(), left: expr, right: right);
      default:
        return expr;
    }
  }

  Expr _factor() {
    var expr = _unary();
    switch (_peek()) {
      case Asterisk():
        _next();
        var right = _factor();
        return BinaryOperator(operator: Asterisk(), left: expr, right: right);
      case Slash():
        _next();
        var right = _factor();
        return BinaryOperator(operator: Slash(), left: expr, right: right);
      default:
        return expr;
    }
  }

  Expr _unary() {
    switch (_peek()) {
      case Minus():
        _next();
        return UnaryOperator(_unary());
      default:
        return _primary();
    }
  }

  Expr _primary() {
    var token = _peek();
    switch (token) {
      case null:
        throw UnimplementedError();
      case Literal():
        _next();
        return token;
      case Dice():
        _next();
        return token;
      case FateDice():
        _next();
        return token;
      case LeftParen():
        _next();
        var expr = Parentheses(_term());
        _next()!;
        return expr;
      default:
        return _term();
    }
  }

  bool match(Token token) {
    if (_peek() == token) {
      _next();
      return true;
    }

    return false;
  }

  Token? _next() {
    if (_tokens.isEmpty) {
      return null;
    }

    return _tokens.removeAt(0);
  }

  Token? _peek() {
    if (_tokens.isEmpty) {
      return null;
    }

    return _tokens.first;
  }
}

sealed class Expr {
  int eval();
  String ast();
  Expr rollDice();
}

class BinaryOperator implements Expr {
  final Token operator;
  final Expr left;
  final Expr right;

  BinaryOperator({
    required this.operator,
    required this.left,
    required this.right,
  });

  @override
  String ast() {
    return "${left.ast()} $operator ${right.ast()}";
  }

  @override
  int eval() {
    var left = this.left.eval();
    var right = this.right.eval();
    switch (operator) {
      case Plus():
        return left + right;
      case Minus():
        return left - right;
      case Asterisk():
        return left * right;
      case Slash():
        return (left / right).floor();
      default:
        throw UnimplementedError();
    }
  }

  @override
  Expr rollDice() {
    return BinaryOperator(
      operator: operator,
      left: left.rollDice(),
      right: right.rollDice(),
    );
  }
}

class UnaryOperator extends Expr {
  final Expr value;

  UnaryOperator(this.value);

  @override
  String ast() {
    return "-${value.ast()}";
  }

  @override
  int eval() {
    return -value.eval();
  }

  @override
  Expr rollDice() {
    return UnaryOperator(value.rollDice());
  }
}

class Parentheses extends Expr {
  final Expr value;

  Parentheses(this.value);

  @override
  String ast() {
    return "(${value.ast()})";
  }

  @override
  int eval() {
    return value.eval();
  }

  @override
  Expr rollDice() {
    return Parentheses(value.rollDice());
  }
}

sealed class Token {}

class Plus implements Token {
  @override
  String toString() => "+";
}

class Minus implements Token {
  @override
  String toString() => "-";
}

class Asterisk implements Token {
  @override
  String toString() => "*";
}

class Slash implements Token {
  @override
  String toString() => "/";
}

class LeftParen implements Token {
  @override
  String toString() => "(";
}

class RightParen implements Token {
  @override
  String toString() => ")";
}

class Literal implements Token, Expr {
  final int value;

  const Literal(this.value);

  @override
  String toString() {
    return value.toString();
  }

  @override
  String ast() {
    return value.toString();
  }

  @override
  int eval() {
    return value;
  }

  @override
  Expr rollDice() {
    return this;
  }
}

class Dice implements Token, Expr {
  final int diceQty;
  final List<int> faces;
  final String display;

  const Dice({
    required this.diceQty,
    required this.faces,
    required this.display,
  });

  @override
  String toString() => display;

  @override
  String ast() => toString();

  @override
  int eval() {
    throw UnimplementedError();
  }

  @override
  Expr rollDice() => RolledDice(this);
}

class FateDice implements Token, Expr {
  final int qtd;

  const FateDice(this.qtd);

  @override
  String toString() => "${qtd}dF";

  @override
  String ast() => toString();

  @override
  int eval() {
    throw UnimplementedError();
  }

  @override
  Expr rollDice() => RolledFateDice(this);
}

class RolledDice implements Expr {
  static final _random = Random();

  Dice dice;
  List<int> _values = [];

  RolledDice(this.dice) {
    _values = List.generate(
        dice.diceQty, (_) => dice.faces[_random.nextInt(dice.faces.length)]);
  }

  @override
  String ast() {
    return "${dice.ast()}(${_values.join(', ')})";
  }

  @override
  int eval() {
    return _values.fold(0, (previousValue, element) => previousValue + element);
  }

  @override
  Expr rollDice() => this;
}

class RolledFateDice implements Expr {
  static final _random = Random();

  FateDice dice;
  List<String> _values = [];

  RolledFateDice(this.dice) {
    const faces = ["-", " ", "+"];
    _values =
        List.generate(dice.qtd, (_) => faces[_random.nextInt(faces.length)]);
  }

  @override
  String ast() {
    return "${dice.ast()}(${_values.join(', ')})";
  }

  @override
  int eval() {
    return _values.fold(0, (previousValue, element) {
      if (element == "-") {
        return previousValue - 1;
      }

      if (element == "+") {
        return previousValue + 1;
      }

      return previousValue;
    });
  }

  @override
  Expr rollDice() => this;
}
