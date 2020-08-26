import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit_type.dart';
import 'package:flutter/foundation.dart';

class Unit {
  final Player player;
  final UnitType type;
  final int range;
  final int speed;
  int x;
  int y;
  int health;

  static int DEFAULT_HEALTH = 10;
  static int DEFAULT_RANGE = 1;
  static int DEFAULT_SPEED = 1;
  static int CONQUER_DAMAGE = 10;

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

  bool get isAlive => health > 0;

  void move(int battlefieldHeight) {
    if (player.id == 1) {
      y -= speed;
    } else if (player.id == 2) {
      y += speed;
    }
  }

  void attack(List<Unit> units) {
    final List<Unit> inColumn = units.where((u) => u.x == x).toList();

    final List<Unit> inRange = _inRange(inColumn);

    if (inRange.isNotEmpty) {
      inRange.sort((u1, u2) => (u1.y - y).abs() - (u2.y - y).abs());
      final Unit unitToAttack = inRange[0];
      final int damage = _damateTo(unitToAttack);
      unitToAttack.health -= damage;
    }
  }

  int _damateTo(Unit unit) {
    if (type == UnitType.circle) {
      switch (unit.type) {
        case UnitType.circle:
          return 2;
        case UnitType.triangle:
          return 3;
        case UnitType.square:
          return 1;
      }
    } else if (type == UnitType.triangle) {
      switch (unit.type) {
        case UnitType.circle:
          return 1;
        case UnitType.triangle:
          return 2;
        case UnitType.square:
          return 3;
      }
    } else if (type == UnitType.square) {
      switch (unit.type) {
        case UnitType.circle:
          return 3;
        case UnitType.triangle:
          return 1;
        case UnitType.square:
          return 2;
      }
    }

    return 0;
  }

  List<Unit> _inRange(List<Unit> inColumn) {
    if (player.id == 1) {
      return inColumn
          .where((u) => (u.y <= y) && (u.y - y).abs() <= range)
          .toList();
    } else if (player.id == 2) {
      return inColumn
          .where((u) => (u.y >= y) && (u.y - y).abs() <= range)
          .toList();
    } else {
      return [];
    }
  }

  int damageToCommandCenter(int battlefieldHeight) {
    final int halfHeight = battlefieldHeight ~/ 2;

    if (player.id == 1) {
      if (y == 0) {
        health = 0;
        return CONQUER_DAMAGE;
      } else if (y < halfHeight) {
        return halfHeight - y;
      }
    } else if (player.id == 2) {
      if (y == (battlefieldHeight - 1)) {
        health = 0;
        return CONQUER_DAMAGE;
      } else if (y > (halfHeight - 1)) {
        return y - halfHeight + 1;
      }
    }

    return 0;
  }

  Unit of({
    int x,
    int y,
    int health,
    int range,
    int speed,
  }) =>
      Unit(
        x: x ?? this.x,
        y: y ?? this.y,
        player: player,
        type: type,
        health: health ?? this.health,
        range: range ?? this.range,
        speed: speed ?? this.speed,
      );
}
