import 'package:cards_game/models/match_map.dart';
import 'package:cards_game/widgets/cell.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final MatchMap map;

  const Grid({@required this.map});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) => Column(
        children: [
          for (int i = 0; i < map.height; i++)
            Row(
              children: [
                for (int j = 0; j < map.width; j++)
                  Cell(
                    x: j,
                    y: i,
                    width: constaints.maxWidth / map.width,
                    height: constaints.maxHeight / map.height,
                    map: map,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
