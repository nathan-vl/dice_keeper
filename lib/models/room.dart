import "package:cloud_firestore/cloud_firestore.dart";

class Room {
  String title;

  DocumentReference gameMasterRef;
  DocumentReference npcsRef;
  DocumentReference locationsRef;

  Room({
    required this.title,
    required this.gameMasterRef,
    required this.locationsRef,
    required this.npcsRef,
  });

  factory Room.fromMap(Map<String, dynamic> map) => Room(
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
