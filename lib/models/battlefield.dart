import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit.dart';

class Battlefield {
  final int width;
  final int height;
  final List<Player> players = [];

  Battlefield(this.width, this.height);

  void addPlayer(Player player) => players.add(player);

  Unit unit(int x, int y) {
    for (final Player player in players) {
      for (final Unit unit in player.units) {
        if ((unit.x == x) && (unit.y == y)) {
          return unit;
        }
      }
    }

    return null;
  }
}
