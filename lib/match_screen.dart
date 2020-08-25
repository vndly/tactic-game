import 'dart:math';
import 'package:cards_game/match_map.dart';
import 'package:cards_game/unit.dart';
import 'package:cards_game/unit_type.dart';
import 'package:flutter/material.dart';

const int MAP_WIDTH = 6;
const int MAP_HEIGHT = 8;

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final MatchMap map = MatchMap();

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
                        ((constaints.maxWidth / MAP_WIDTH) * MAP_HEIGHT)) /
                    2,
                onTap: _onCommandCenterTapped,
              ),
              Expanded(child: Grid(map: map)),
              CommandCenter(
                player: 1,
                color: Colors.blue,
                height: (constaints.maxHeight -
                        ((constaints.maxWidth / MAP_WIDTH) * MAP_HEIGHT)) /
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
          x: Random().nextInt(MAP_WIDTH),
          y: Random().nextInt(MAP_HEIGHT),
          player: player,
          type: UnitType.rifle_squad,
        ),
      );
    });
  }
}

class CommandCenter extends StatelessWidget {
  final int player;
  final Color color;
  final double height;
  final Function(int) onTap;

  const CommandCenter({
    @required this.player,
    @required this.color,
    @required this.height,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(player),
          child: Center(
            child: RotatedBox(
              quarterTurns: (player == 1) ? 0 : 2,
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

class Cell extends StatelessWidget {
  final int x;
  final int y;
  final double width;
  final double height;
  final MatchMap map;

  const Cell({
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
    @required this.map,
  });

  @override
  Widget build(BuildContext context) {
    final Unit unit = map.unit(x, y);

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
                    color: (unit.player == 1) ? Colors.blue : Colors.red),
              ),
            )
          : Container(),
    );
  }
}

class Grid extends StatelessWidget {
  final MatchMap map;

  const Grid({@required this.map});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) => Column(
        children: [
          for (int i = 0; i < MAP_HEIGHT; i++)
            Row(
              children: [
                Cell(
                  x: 0,
                  y: i,
                  width: constaints.maxWidth / MAP_WIDTH,
                  height: constaints.maxHeight / MAP_HEIGHT,
                  map: map,
                ),
                Cell(
                  x: 1,
                  y: i,
                  width: constaints.maxWidth / MAP_WIDTH,
                  height: constaints.maxHeight / MAP_HEIGHT,
                  map: map,
                ),
                Cell(
                  x: 2,
                  y: i,
                  width: constaints.maxWidth / MAP_WIDTH,
                  height: constaints.maxHeight / MAP_HEIGHT,
                  map: map,
                ),
                Cell(
                  x: 3,
                  y: i,
                  width: constaints.maxWidth / MAP_WIDTH,
                  height: constaints.maxHeight / MAP_HEIGHT,
                  map: map,
                ),
                Cell(
                  x: 4,
                  y: i,
                  width: constaints.maxWidth / MAP_WIDTH,
                  height: constaints.maxHeight / MAP_HEIGHT,
                  map: map,
                ),
                Cell(
                  x: 5,
                  y: i,
                  width: constaints.maxWidth / MAP_WIDTH,
                  height: constaints.maxHeight / MAP_HEIGHT,
                  map: map,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
