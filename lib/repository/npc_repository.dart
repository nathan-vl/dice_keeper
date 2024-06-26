import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/npc.dart';

final _db = FirebaseFirestore.instance;

class NPCRepository {
  static Future<List<NPC>> get(String npcsDoc) async {
    final document = await _db.collection("npcs").doc(npcsDoc).get();
    final data = document.data()!;
    final items = data["items"];
    final npcs = items.map((npc) => NPC.fromMap(npc));
    return List<NPC>.from(npcs.toList() as List);
  }

  static void update(String npcsDoc, List<NPC> npcs) async {
    final items = npcs.map((npc) => npc.toMap());
    await _db.collection("npcs").doc(npcsDoc).update({"items": items});
  }
}
