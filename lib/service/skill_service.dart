import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/skill.dart';

final _db = FirebaseFirestore.instance;

class SkillService {
  static Future<List<Skill>> get() async {
    final document =
        await _db.collection("rpg_properties").doc("properties").get();
    final data = document.data()!;
    final items = data["pericias"];
    final skills = items.map((skill) => Skill.fromMap(skill));
    return List<Skill>.from(skills.toList() as List);
  }
}
