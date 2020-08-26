import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/unit.dart';
import 'package:cards_game/widgets/cell.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final Battlefield battlefield;
  final Unit unitToPlace;
  final Function(Unit) onUnitPlaced;

  const Grid({
    @required this.battlefield,
    @required this.unitToPlace,
    @required this.onUnitPlaced,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) => Column(
        children: [
          for (int i = 0; i < battlefield.height; i++)
            Row(
              children: [
                for (int j = 0; j < battlefield.width; j++)
                  Cell(
                    x: j,
                    y: i,
                    width: constaints.maxWidth / battlefield.width,
                    height: constaints.maxHeight / battlefield.height,
                    battlefield: battlefield,
                    onTap: (unitToPlace != null)
                        ? () => onUnitPlaced(unitToPlace.of(x: j, y: i))
                        : null,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
