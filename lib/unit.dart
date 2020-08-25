import 'package:cards_game/unit_type.dart';
import 'package:flutter/foundation.dart';

class Unit {
  final int x;
  final int y;
  final int player;
  final UnitType type;

  const Unit({
    @required this.x,
    @required this.y,
    @required this.player,
    @required this.type,
  });
}
