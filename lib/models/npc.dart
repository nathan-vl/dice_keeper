class NPC {
  String title;
  String description;

  NPC({required this.title, required this.description});

  NPC clone() {
    return NPC(title: title, description: description);
  }

  factory NPC.fromMap(Map<String, dynamic> map) => NPC(
        title: map['title'],
        description: map['description'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
      };
}
