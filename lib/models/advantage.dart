class Advantage {
  final String name;
  final String description;

  Advantage({required this.name, required this.description});
  Advantage clone() {
    return Advantage(name: name, description: description);
  }

  factory Advantage.fromMap(Map<String, dynamic> map) => Advantage(
        name: map["nome"],
        description: map["descricao"],
      );

  Map<String, dynamic> toMap() => {
        "nome": name,
        "descricao": description,
      };
}
