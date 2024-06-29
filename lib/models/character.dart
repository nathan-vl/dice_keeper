import 'package:dice_keeper/models/advantage.dart';
import 'package:dice_keeper/models/disadvantage.dart';
import 'package:dice_keeper/models/item.dart';
import 'package:dice_keeper/models/skill.dart';

class Character {
  String name, history;
  int level;
  int str, abi, mp, hp, pof, res, arm;
  List<Advantage> advantages;
  List<Disadvantage> disadvantages;
  List<Item> inventory;
  List<Skill> skills;
  String roomId;
  String playerId;

  Character({
    required this.name,
    required this.level,
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
    var advantages = List<Advantage>.from(
        map["advantages"].map((a) => Advantage.fromMap(a)).toList() as List);
    final disadvantages = List<Disadvantage>.from(map["disadvantages"]
        .map((d) => Disadvantage.fromMap(d))
        .toList() as List);
    final inventory = List<Item>.from(
        map["inventory"].map((i) => Item.fromMap(i)).toList() as List);
    final skills = List<Skill>.from(
        map["skills"].map((s) => Skill.fromMap(s)).toList() as List);

    return Character(
      name: map["name"],
      level: map["level"],
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
        "level": level,
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
