import 'package:dice_keeper/models/advantage.dart';
import 'package:dice_keeper/models/disadvantage.dart';
import 'package:dice_keeper/models/item.dart';
import 'package:dice_keeper/models/room.dart';
import 'package:dice_keeper/models/skill.dart';

class Character {
  final String name, history;
  final int str, abi, mp, hp, pof, res, arm;
  final List<Advantage> advantages;
  final List<Disadvantage> disadvantages;
  final List<Item> inventory;
  final List<Skill> skills;
  final String roomId;

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
  });

  factory Character.fromMap(Map<String, dynamic> map) => Character(
        name: map["name"],
        history: map["history"],
        str: map["str"],
        abi: map["abi"],
        mp: map["mp"],
        hp: map["hp"],
        pof: map["pof"],
        res: map["res"],
        arm: map["arm"],
        advantages: map["advantages"].map(Advantage.fromMap),
        disadvantages: map["disadvantages"].map(Disadvantage.fromMap),
        inventory: map["inventory"].map(Item.fromMap),
        skills: map["skills"].map(Skill.fromMap), 
        roomId: map["roomId"],
      );

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
        "disadvantages": disadvantages.map((disadvantage) => disadvantage.toMap()),
        "inventory": inventory.map((item) => item.toMap()),
        "skills": skills.map((skill) => skill.toMap()),
        "roomId": roomId, 
      };
}
