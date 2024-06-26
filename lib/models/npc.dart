class NPC {
  String title = "";
  String description = "";

  NPC({required this.title, required this.description});

  NPC clone() {
    return NPC(title: title, description: description);
  }

  NPC.fromDynamic(dynamic npcMap) {
    title = npcMap['title'];
    description = npcMap['description'];
  }
}
