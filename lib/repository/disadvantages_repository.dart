import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/disadvantage.dart';

final _db = FirebaseFirestore.instance;

class DisadvantagesRepository {
  static Future<List<Disadvantage>> get() async {
    final document =
        await _db.collection("rpg_properties").doc("properties").get();
    final data = document.data()!;
    final items = data["desvantagens"];
    final disadvantages = items.map((disadvantage) => Disadvantage.fromMap(disadvantage));
    return List<Disadvantage>.from(disadvantages.toList() as List);
  }
}
