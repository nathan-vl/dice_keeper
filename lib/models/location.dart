class Location {
  String title;
  String description;

  Location({required this.title, required this.description});

  Location clone() {
    return Location(title: title, description: description);
  }

  factory Location.fromMap(Map<String, dynamic> map) => Location(
        title: map['title'],
        description: map['description'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
      };
}
