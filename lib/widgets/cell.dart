import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/unit.dart';
import 'package:cards_game/widgets/multiple_units_widget.dart';
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
  final Function(List<Unit>) onShowUnits;

  const Cell({
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
    @required this.battlefield,
    @required this.onPlaceUnit,
    @required this.onRemoveUnit,
    @required this.onShowUnits,
  });

  @override
  Widget build(BuildContext context) {
    final List<Unit> units = battlefield.units(x, y);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.3,
          color: Color(0xff222222),
        ),
      ),
      child: (units.isNotEmpty)
          ? ((units.length == 1)
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onRemoveUnit(units[0]),
                    child: RotatedBox(
                      quarterTurns: units[0].player.quarterTurns,
                      child: UnitWidget(unit: units[0]),
                    ),
                  ),
                )
              : Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onShowUnits(units),
                    child: MultipleUnitsWidget(),
                  ),
                ))
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
