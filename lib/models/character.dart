import 'package:dice_keeper/models/advantage.dart';
import 'package:dice_keeper/models/disadvantage.dart';
import 'package:dice_keeper/models/item.dart';
import 'package:dice_keeper/models/skill.dart';

class Character {
  final String name, history;
  final int str, abi, mp, hp, pof, res, arm;
  final List<Advantage> advantages;
  final List<Disadvantage> disadvantages;
  final List<Item> inventory;
  final List<Skill> skills;
  final String roomId;
  final String playerId;

  Character({
    required this.name,
    required this.history,
    required this.str,
    required this.abi,
    required this.mp,
    required this.hp,
    required this.pof,
    required this.res,
    required this.arm,
    required this.advantages,
    required this.disadvantages,
    required this.inventory,
    required this.skills,
    required this.roomId,
    required this.playerId,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    final advantages = map["advantages"].isEmpty
        ? List<Advantage>.empty()
        : List<Advantage>.from(
            map["advantages"].map(Advantage.fromMap).toList() as List);

    final disadvantages = map["disadvantages"].isEmpty
        ? List<Disadvantage>.empty()
        : List<Disadvantage>.from(
            map["disadvantages"].map(Disadvantage.fromMap).toList() as List);

    final inventory = map["inventory"].isEmpty
        ? List<Item>.empty()
        : List<Item>.from(map["inventory"].map(Item.fromMap).toList() as List);

    final skills = map["skills"].isEmpty
        ? List<Skill>.empty()
        : List<Skill>.from(map["skills"].map(Skill.fromMap).toList() as List);

    return Character(
      name: map["name"],
      history: map["history"],
      str: map["str"],
      abi: map["abi"],
      mp: map["mp"],
      hp: map["hp"],
      pof: map["pof"],
      res: map["res"],
      arm: map["arm"],
      advantages: advantages,
      disadvantages: disadvantages,
      inventory: inventory,
      skills: skills,
      roomId: map["roomId"],
      playerId: map["playerId"],
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "history": history,
        "str": str,
        "abi": abi,
        "mp": mp,
        "hp": hp,
        "pof": pof,
        "res": res,
        "arm": arm,
        "advantages": advantages.map((advantage) => advantage.toMap()),
        "disadvantages":
            disadvantages.map((disadvantage) => disadvantage.toMap()),
        "inventory": inventory.map((item) => item.toMap()),
        "skills": skills.map((skill) => skill.toMap()),
        "roomId": roomId,
        "playerId": playerId,
      };
}
