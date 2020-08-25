import 'package:cards_game/models/player.dart';
import 'package:flutter/material.dart';

class CommandCenter extends StatelessWidget {
  final Player player;
  final double height;
  final Function(Player) onTap;

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
      color: player.color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(player),
          child: Center(
            child: RotatedBox(
              quarterTurns: player.quarterTurns,
              child: Text(
                'COMMAND  CENTER',
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
}
