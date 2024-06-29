import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/character.dart';

class CharactersRepository {
  static final _db = FirebaseFirestore.instance;
  static final collection = _db.collection("characters");

  static Future<Character?> get(String id) async {
    final document = await collection.doc(id).get();
    final data = document.data();
    if (data == null) {
      return null;
    } else {
      return Character.fromMap(data);
    }
  }

  static Future<List<Character>> getByPlayer(String player) async {
    final items = await collection.where('playerId', isEqualTo: player).get();
    final characters =
        items.docs.map((character) => Character.fromMap(character.data()));
    return List<Character>.from(characters.toList() as List);
  }

  static Future<List<String>> getIdsByPlayer(String player) async {
    final items = await collection.where('playerId', isEqualTo: player).get();
    final characters = items.docs.map((character) => character.id).toList();
    return characters;
  }

  static Future<Character?> getByPlayerAndRoom(
      String player, String room) async {
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

  static Future<DocumentReference<Map<String, dynamic>>> insertCharacter(
    Character character,
  ) {
    return collection.add(character.toMap());
  }
}
