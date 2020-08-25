import 'dart:math';
import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit.dart';
import 'package:cards_game/models/unit_type.dart';
import 'package:cards_game/widgets/command_center.dart';
import 'package:cards_game/widgets/grid.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  final Battlefield battlefield;

  const MatchScreen({@required this.battlefield});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: LayoutBuilder(
          builder: (context, constaints) => Column(
            children: [
              CommandCenter(
                player: widget.battlefield.players[1],
                height: (constaints.maxHeight -
                        ((constaints.maxWidth / widget.battlefield.width) *
                            widget.battlefield.height)) /
                    2,
                onTap: _onCommandCenterTapped,
              ),
              Expanded(child: Grid(battlefield: widget.battlefield)),
              CommandCenter(
                player: widget.battlefield.players[0],
                height: (constaints.maxHeight -
                        ((constaints.maxWidth / widget.battlefield.width) *
                            widget.battlefield.height)) /
                    2,
                onTap: _onCommandCenterTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCommandCenterTapped(BuildContext context, Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return RotatedBox(
          quarterTurns: player.quarterTurns,
          child: SimpleDialog(
            title: Center(
              child: Text(
                'Player ${player.id}',
                style: TextStyle(color: player.color),
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onCreateUnit(player);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      const Text('Crate unit', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onPassturn(player);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(Icons.fast_forward),
                      SizedBox(width: 10),
                      const Text('Pass turn', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onCreateUnit(Player player) {
    setState(() {
      player.addUnit(
        Unit(
          x: Random().nextInt(widget.battlefield.width),
          y: Random().nextInt(widget.battlefield.height),
          player: player,
          type: UnitType.values[Random().nextInt(UnitType.values.length)],
          health: 10,
        ),
      );
    });
  }

  void _onPassturn(Player player) {
    setState(() {
      player.turnPassed = true;
    });
  }
}
