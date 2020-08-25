import 'package:cards_game/unit.dart';

class MatchMap {
  final Map<int, List<Unit>> _units = {};

  void addUnit(int player, Unit unit) {
    final List<Unit> list = _units[player];

    if (list != null) {
      list.add(unit);
    } else {
      _units[player] = [unit];
    }
  }

  Unit unit(int x, int y) {
    for (final int player in _units.keys) {
      for (final Unit unit in _units[player]) {
        if ((unit.x == x) && (unit.y == y)) {
          return unit;
        }
      }
    }

    return null;
  }
}
