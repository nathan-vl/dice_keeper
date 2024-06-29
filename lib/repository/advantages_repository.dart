import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/skill.dart';

final _db = FirebaseFirestore.instance;

class AdvantagesRepository {
  static Future<List<Skill>> get() async {
    final document =
        await _db.collection("rpg_properties").doc("properties").get();
    final data = document.data()!;
    final items = data["vantagens"];
    final advantages = items.map((advantage) => Skill.fromMap(advantage));
    return List<Skill>.from(advantages.toList() as List);
  }
}
