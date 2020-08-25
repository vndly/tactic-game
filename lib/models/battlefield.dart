import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit.dart';

class Battlefield {
  final int width;
  final int height;
  final List<Player> players = [];

  Battlefield(this.width, this.height);

  void addPlayer(Player player) => players.add(player);

  bool get allPlayersPassedTurn {
    for (final Player player in players) {
      if (!player.turnPassed) {
        return false;
      }
    }

    return true;
  }

  void passTurn() {
    for (final Player player in players) {
      player.turnPassed = false;
    }

    // TODO(momo): move units
    // TODO(momo): fight

    for (final Player player in players) {
      if (player.health == 0) {
        // TODO(momo): player lost
      }
    }

    for (final Player player in players) {
      player.commandPoints++;
      // TODO(momo): increase cp
    }
  }

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
