import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/widgets/cell.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final Battlefield battlefield;

  const Grid({@required this.battlefield});

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
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
