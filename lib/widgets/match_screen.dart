import 'dart:math';
import 'package:cards_game/models/match_map.dart';
import 'package:cards_game/unit.dart';
import 'package:cards_game/unit_type.dart';
import 'package:cards_game/widgets/command_center.dart';
import 'package:cards_game/widgets/grid.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final MatchMap map = MatchMap(6, 8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: LayoutBuilder(
          builder: (context, constaints) => Column(
            children: [
              CommandCenter(
                player: 2,
                color: Colors.red,
                height: (constaints.maxHeight -
                        ((constaints.maxWidth / map.width) * map.height)) /
                    2,
                onTap: _onCommandCenterTapped,
              ),
              Expanded(child: Grid(map: map)),
              CommandCenter(
                player: 1,
                color: Colors.blue,
                height: (constaints.maxHeight -
                        ((constaints.maxWidth / map.width) * map.height)) /
                    2,
                onTap: _onCommandCenterTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCommandCenterTapped(int player) {
    setState(() {
      map.addUnit(
        player,
        Unit(
          x: Random().nextInt(map.width),
          y: Random().nextInt(map.height),
          player: player,
          type: UnitType.circle,
        ),
      );
    });
  }
}
