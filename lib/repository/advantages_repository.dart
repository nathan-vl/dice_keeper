import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/advantage.dart';

final _db = FirebaseFirestore.instance;

class AdvantagesRepository {
  static Future<List<Advantage>> get() async {
    final document =
        await _db.collection("rpg_properties").doc("properties").get();
    final data = document.data()!;
    final items = data["vantagens"];
    final advantages = items.map((advantage) => Advantage.fromMap(advantage));
    return List<Advantage>.from(advantages.toList() as List);
  }
}
