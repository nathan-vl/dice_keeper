class Skill {
  final String name;
  final String description;

  Skill({required this.name, required this.description});
  Skill clone() {
    return Skill(name: name, description: description);
  }

  factory Skill.fromMap(Map<String, dynamic> map) => Skill(
        name: map["nome"],
        description: map["descricao"],
      );

  Map<String, dynamic> toMap() => {
        "nome": name,
        "descricao": description,
      };
}
