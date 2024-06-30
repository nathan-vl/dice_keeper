import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/models/room.dart';

final _db = FirebaseFirestore.instance;

class RoomRepository {
  static Future<Room> get(String id) async {
    final document = await _db.collection("rooms").doc(id).get();
    final data = document.data()!;
    return Room.fromMap(data, id);
  }

  static void update(String roomDoc, Room room) async {
    await _db.collection("rooms").doc(roomDoc).update(room.toMap());
  }

  static Future<Room?> findByToken(String token) async {
    final document = _db.collection("rooms");
    final rooms = await document.where('token', isEqualTo: token).get();
    if (rooms.size == 0) {
      return null;
    }

    final room = Room.fromMap(rooms.docs.first.data(), rooms.docs.first.id);
    return room;
  }

  static Future<List<Room>> getByMaster(String masterId) async {
    final document = _db.collection("rooms");
    final items = await document.where('gameMaster', isEqualTo: masterId).get();
    final rooms = items.docs.map((room) => Room.fromMap(room.data(), room.id));
    return List<Room>.from(rooms.toList() as List);
  }

  static Future<List<String>> getIdsByMaster(String masterId) async {
    final collection = _db.collection("rooms");
    final items =
        await collection.where('gameMaster', isEqualTo: masterId).get();
    final rooms = items.docs.map((room) => room.id).toList();
    return rooms;
  }
}
