import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/character.dart';

class CharactersRepository {
  static final _db = FirebaseFirestore.instance;
  static final collection = _db.collection("characters");

  static Future<List<Character>> getByPlayer(String player) async {
    final items = await collection.where('playerId', isEqualTo: player).get();
    final characters =
        items.docs.map((character) => Character.fromMap(character.data()));
    return List<Character>.from(characters.toList() as List);
  }

  static Future<Character?> getByPlayerAndRoom(
      String player, String room) async {
    print("Player: $player");
    print("Room: $room");

    final query = await collection
        .where('playerId', isEqualTo: player)
        .where('roomId', isEqualTo: room)
        .get();

    if (query.size == 0) {
      return null;
    }

    final character = Character.fromMap(query.docs.first.data());
    return character;
  }

  static void insertCharacter(Character character) {
    collection.add(character.toMap());
  }
}
