import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/character.dart';

final _db = FirebaseFirestore.instance;

class CharactersRepository {
  static Future<List<Character>> getByPlayer(String player) async {
    final document = _db.collection("characters");
    final items = await document.where('player', isEqualTo: player).get();
    final characters = items.docs.map((character) => Character.fromMap(character.data()));
    return List<Character>.from(characters.toList() as List);
  }

}
