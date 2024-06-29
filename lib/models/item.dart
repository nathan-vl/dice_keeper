class Item {
  final String name;
  final String effect;

  Item({required this.name, required this.effect});
  Item clone() {
    return Item(name: name, effect: effect);
  }

  factory Item.fromMap(Map<String, dynamic> map) => Item(
        name: map["nome"],
        effect: map["efeito"],
      );

  Map<String, dynamic> toMap() => {
        "nome": name,
        "efeito": effect,
      };
}
