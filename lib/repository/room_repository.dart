import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/room.dart';

final _db = FirebaseFirestore.instance;

class RoomRepository {
  static Future<Room> get(String npcsDoc) async {
    final document = await _db.collection("rooms").doc(npcsDoc).get();
    final data = document.data()!;
    return Room.fromMap(data);
  }

  static void update(String roomDoc, Room room) async {
    await _db.collection("rooms").doc(roomDoc).update(room.toMap());
  }
}
