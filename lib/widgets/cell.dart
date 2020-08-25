import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/unit.dart';
import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final int x;
  final int y;
  final double width;
  final double height;
  final Battlefield battlefield;

  const Cell({
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
    @required this.battlefield,
  });

  @override
  Widget build(BuildContext context) {
    final Unit unit = battlefield.unit(x, y);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.3,
          color: Color(0xff222222),
        ),
      ),
      child: (unit != null)
          ? Center(
              child: Text(
                unit.type.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: unit.player.color,
                ),
              ),
            )
          : Container(),
    );
  }
}
