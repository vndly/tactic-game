import 'package:cards_game/models/unit.dart';
import 'package:flutter/material.dart';

class Player {
  final int id;
  final Color color;
  final int quarterTurns;
  final List<Unit> units = [];
  int commandPoints;
  int health;

  Player({
    @required this.id,
    @required this.color,
    @required this.commandPoints,
    @required this.health,
  }) : quarterTurns = (id == 1) ? 0 : 2;

  void addUnit(Unit unit) => units.add(unit);
}
