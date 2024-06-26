import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/npc.dart';

final _db = FirebaseFirestore.instance;

Future<List<NPC>> getNpcs(String npcsDoc) async {
  var document = await _db.collection("roomNpcs").doc(npcsDoc).get();
  final data = document.data()!;
  final items = data["items"];
  final npcs = items.map((npc) => NPC.fromDynamic(npc));
  final l = List<NPC>.from(npcs.toList() as List);
  return l;
}
