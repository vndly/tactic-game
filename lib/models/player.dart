import 'package:cards_game/models/unit.dart';
import 'package:flutter/material.dart';

class Player {
  final int id;
  final Color color;
  final List<Unit> units = [];
  int health;

  Player({
    @required this.id,
    @required this.color,
    @required this.health,
  });

  void addUnit(Unit unit) => units.add(unit);
}
