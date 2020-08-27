import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/player.dart';
import 'package:cards_game/models/unit.dart';
import 'package:cards_game/models/unit_type.dart';
import 'package:cards_game/widgets/command_center.dart';
import 'package:cards_game/widgets/customize_unit_dialog.dart';
import 'package:cards_game/widgets/grid.dart';
import 'package:cards_game/widgets/unit_widget.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  final Battlefield battlefield;

  const MatchScreen({@required this.battlefield});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  Unit unitToPlace;

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
                height: _commandCenterHeight(constaints),
                onTap: _onCommandCenterTapped,
              ),
              Expanded(
                child: Grid(
                  battlefield: widget.battlefield,
                  unitToPlace: unitToPlace,
                  onUnitPlaced: _onCreateUnit,
                ),
              ),
              CommandCenter(
                player: widget.battlefield.players[0],
                height: _commandCenterHeight(constaints),
                onTap: _onCommandCenterTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _commandCenterHeight(BoxConstraints constaints) =>
      (constaints.maxHeight -
          ((constaints.maxWidth / widget.battlefield.width) *
              widget.battlefield.height)) /
      2;

  void _onCommandCenterTapped(BuildContext context, Player player) {
    setState(() {
      unitToPlace = null;
    });

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
                  _onSelectUnit(player);
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

  void _onSelectUnit(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return RotatedBox(
          quarterTurns: player.quarterTurns,
          child: SimpleDialog(
            title: Center(
              child: Text(
                'Select type',
                style: TextStyle(color: player.color),
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onCustomizeUnit(Unit.of(player, UnitType.circle));
                },
                child: Row(
                  children: [
                    UnitRow(
                      player: player,
                      type: UnitType.circle,
                      width: 50,
                      height: 50,
                      padding: 10,
                    ),
                    SizedBox(width: 10),
                    const Text('Circle', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onCustomizeUnit(Unit.of(player, UnitType.triangle));
                },
                child: Row(
                  children: [
                    UnitRow(
                      player: player,
                      type: UnitType.triangle,
                      width: 50,
                      height: 50,
                      padding: 10,
                    ),
                    SizedBox(width: 10),
                    const Text('Triangle', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onCustomizeUnit(Unit.of(player, UnitType.square));
                },
                child: Row(
                  children: [
                    UnitRow(
                      player: player,
                      type: UnitType.square,
                      width: 50,
                      height: 50,
                      padding: 10,
                    ),
                    SizedBox(width: 10),
                    const Text('Square', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onCustomizeUnit(Unit unit) {
    showDialog(
      context: context,
      builder: (context) {
        return RotatedBox(
          quarterTurns: unit.player.quarterTurns,
          child: CustomizeUnitDialog(
            unit: unit,
            availableCP: unit.player.commandPoints,
            onAccept: _onSelectStartCell,
          ),
        );
      },
    );
  }

  void _onSelectStartCell(Unit unit) {
    setState(() {
      unitToPlace = unit;
    });
  }

  void _onCreateUnit(Unit unit) {
    setState(() {
      if (widget.battlefield.canCreateUnit(unit)) {
        unit.player.addUnit(unit);
        unitToPlace = null;

        if (unit.player.commandPoints == 0) {
          _onPassturn(unit.player);
        }
      }
    });
  }

  void _onPassturn(Player player) {
    setState(() {
      player.turnPassed = true;

      if (widget.battlefield.allPlayersPassedTurn) {
        widget.battlefield.passTurn();
      }
    });
  }
}

class UnitRow extends StatelessWidget {
  final Player player;
  final UnitType type;
  final double width;
  final double height;
  final double padding;

  const UnitRow({
    @required this.player,
    @required this.type,
    @required this.width,
    @required this.height,
    @required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: UnitWidget(
        unit: Unit.of(player, type),
        showStats: false,
        padding: padding,
      ),
    );
  }
}
