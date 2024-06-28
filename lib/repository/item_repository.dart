import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/item.dart';

final _db = FirebaseFirestore.instance;

class ItemRepository {
  static Future<List<Item>> get() async {
    final document =
        await _db.collection("rpg_properties").doc("properties").get();
    final data = document.data()!;
    final itensList = data["itens"];
    final items = itensList.map((item) => Item.fromMap(item));
    return List<Item>.from(items.toList() as List);
  }
}
