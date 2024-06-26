class Location {
  String title = "";
  String description = "";

  Location({required this.title, required this.description});

  Location clone() {
    return Location(title: title, description: description);
  }

  Location.fromDynamic(dynamic npcMap) {
    title = npcMap['title'];
    description = npcMap['description'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
