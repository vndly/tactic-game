import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit_type.dart';
import 'package:flutter/foundation.dart';

class Unit {
  final int x;
  final int y;
  final Player player;
  final UnitType type;
  final int range;
  final int speed;
  int health;

  static int DEFAULT_HEALTH = 10;
  static int DEFAULT_RANGE = 1;
  static int DEFAULT_SPEED = 1;

  Unit({
    @required this.x,
    @required this.y,
    @required this.player,
    @required this.type,
    @required this.range,
    @required this.speed,
    @required this.health,
  });

  factory Unit.of(Player player, UnitType type) => Unit(
        x: 0,
        y: 0,
        player: player,
        type: type,
        range: DEFAULT_RANGE,
        speed: DEFAULT_SPEED,
        health: DEFAULT_HEALTH,
      );

  int get cost => (health * 3 / 10).round() + range + speed;

  Unit of({
    int health,
    int range,
    int speed,
  }) =>
      Unit(
        x: x,
        y: y,
        player: player,
        type: type,
        health: health ?? this.health,
        range: range ?? this.range,
        speed: speed ?? this.speed,
      );
}
