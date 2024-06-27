import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/location.dart';

final _db = FirebaseFirestore.instance;

class LocationService {
  static Future<List<Location>> get(String locationsDoc) async {
    final document = await _db.collection("locations").doc(locationsDoc).get();
    final data = document.data()!;
    final items = data["items"];
    final locations = items.map((location) => Location.fromMap(location));
    return List<Location>.from(locations.toList() as List);
  }

  static void update(String locationsDoc, List<Location> locations) async {
    final items = locations.map((location) => location.toMap());
    await _db
        .collection("locations")
        .doc(locationsDoc)
        .update({"items": items});
  }
}
