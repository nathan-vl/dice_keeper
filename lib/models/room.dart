class Room {
  final String id, title;
  final String gameMasterRef, npcsRef, locationsRef;

  Room({
    required this.id,
    required this.title,
    required this.gameMasterRef,
    required this.locationsRef,
    required this.npcsRef,
  });

  factory Room.fromMap(Map<String, dynamic> map, String id) => Room(
        id: id,
        title: map["title"],
        gameMasterRef: map["gameMaster"],
        locationsRef: map["locations"],
        npcsRef: map["npcs"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "gameMaster": gameMasterRef,
        "npcs": npcsRef,
        "locations": locationsRef,
      };
}
