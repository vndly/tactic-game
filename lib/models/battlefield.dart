import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit.dart';

class Battlefield {
  final int width;
  final int height;
  final List<Player> players = [];
  int lastTurnCp = 0;

  Battlefield(this.width, this.height);

  void addPlayer(Player player) {
    players.add(player);
    lastTurnCp = player.commandPoints;
  }

  bool get allPlayersPassedTurn {
    for (final Player player in players) {
      if (!player.turnPassed) {
        return false;
      }
    }

    return true;
  }

  bool canCreateUnit(Unit unit) {
    if ((unit.player.id == 1) && (unit.y == (height - 1))) {
      return true;
    }

    if ((unit.player.id == 2) && (unit.y == 0)) {
      return true;
    }

    return false;
  }

  void passTurn() {
    for (final Player player in players) {
      for (final Unit unit in player.units) {
        unit.move(height);
      }
    }

    for (final Player player in players) {
      for (final Unit unit in player.units) {
        if (player.id == 1) {
          unit.attackUnits(players[1].units);
        } else if (player.id == 2) {
          unit.attackUnits(players[0].units);
        }
      }
    }

    for (final Player player in players) {
      int damage = 0;

      for (final Unit unit in player.units) {
        damage += unit.damageToCommandCenter(height);
      }

      if (player.id == 1) {
        players[1].health -= damage;
      } else if (player.id == 2) {
        players[0].health -= damage;
      }
    }

    for (final Player player in players) {
      player.clearUnits();
    }

    if ((players[0].health > 0) && (players[1].health < 0)) {
      players[0].status = Status.winner;
      players[1].status = Status.loser;
    } else if ((players[0].health < 0) && (players[1].health > 0)) {
      players[0].status = Status.loser;
      players[1].status = Status.winner;
    }

    for (final Player player in players) {
      player.turnPassed = false;
    }

    for (final Player player in players) {
      player.commandPoints += lastTurnCp + 1;
    }

    lastTurnCp++;
  }

  List<Unit> units(int x, int y) {
    final List<Unit> result = [];

    for (final Player player in players) {
      for (final Unit unit in player.units) {
        if ((unit.x == x) && (unit.y == y)) {
          result.add(unit);
        }
      }
    }

    return result;
  }
}
