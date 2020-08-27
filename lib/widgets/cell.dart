import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/unit.dart';
import 'package:cards_game/widgets/unit_widget.dart';
import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final int x;
  final int y;
  final double width;
  final double height;
  final Battlefield battlefield;
  final Function onPlaceUnit;
  final Function(Unit) onRemoveUnit;

  const Cell({
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
    @required this.battlefield,
    @required this.onPlaceUnit,
    @required this.onRemoveUnit,
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
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onRemoveUnit(unit),
                child: RotatedBox(
                  quarterTurns: unit.player.quarterTurns,
                  child: UnitWidget(unit: unit),
                ),
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onPlaceUnit?.call(),
                child: Container(),
              ),
            ),
    );
  }
}
