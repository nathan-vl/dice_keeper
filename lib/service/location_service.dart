import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/location.dart';

final _db = FirebaseFirestore.instance;

class LocationService {
  static Future<List<Location>> get(String locationsDoc) async {
    final document = await _db.collection("locations").doc(locationsDoc).get();
    final data = document.data()!;
    final items = data["items"];
    final locations = items.map((location) => Location.fromDynamic(location));
    final l = List<Location>.from(locations.toList() as List);
    return l;
  }

  static void update(String locationsDoc, List<Location> locations) async {
    final items = locations.map((location) => location.toJson());
    await _db.collection("npcs").doc(locationsDoc).update({"items": items});
  }
}
