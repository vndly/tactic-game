import 'package:cards_game/models/player.dart';
import 'package:flutter/material.dart';

class CommandCenter extends StatelessWidget {
  final Player player;
  final double height;
  final Function(BuildContext, Player) onTap;

  const CommandCenter({
    @required this.player,
    @required this.height,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: (player.turnPassed) ? Colors.grey : player.color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (player.turnPassed || player.status != Status.playing)
              ? null
              : () => onTap(context, player),
          child: Center(
            child: RotatedBox(
              quarterTurns: player.quarterTurns,
              child: Text(
                text(player),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String text(Player player) {
    switch (player.status) {
      case Status.playing:
        return 'CP: ${player.commandPoints}   /   HEALTH: ${player.health}';
      case Status.winner:
        return 'WINNER';
      case Status.loser:
        return 'LOSER';
      default:
        return '';
    }
  }
}
