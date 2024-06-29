class Disadvantage {
  final String name;
  final String description;

  Disadvantage({required this.name, required this.description});
  Disadvantage clone() {
    return Disadvantage(name: name, description: description);
  }

  factory Disadvantage.fromMap(Map<String, dynamic> map) => Disadvantage(
        name: map["nome"],
        description: map["descricao"],
      );

  Map<String, dynamic> toMap() => {
        "nome": name,
        "descricao": description,
      };
}
