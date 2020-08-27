import 'package:cards_game/models/unit.dart';
import 'package:cards_game/widgets/match_screen.dart';
import 'package:flutter/material.dart';

class CustomizeUnitDialog extends StatefulWidget {
  final Unit unit;
  final int availableCP;
  final Function(Unit) onAccept;

  const CustomizeUnitDialog({
    @required this.unit,
    @required this.availableCP,
    @required this.onAccept,
  });

  @override
  _CustomizeUnitDialogState createState() => _CustomizeUnitDialogState(unit);
}

class _CustomizeUnitDialogState extends State<CustomizeUnitDialog> {
  Unit unit;

  _CustomizeUnitDialogState(this.unit);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UnitRow(
              player: widget.unit.player,
              type: widget.unit.type,
              width: 30,
              height: 30,
              padding: 0,
            ),
            SizedBox(width: 15),
            Text(
              'Customize unit',
              style: TextStyle(color: widget.unit.player.color),
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FieldEditor(
            title: 'Health',
            value: widget.unit.health,
            step: 10,
            min: Unit.DEFAULT_HEALTH,
            max: 100,
            onChange: (value) {
              setState(() {
                unit = unit.of(health: value);
              });
            },
          ),
          FieldEditor(
            title: 'Attack',
            value: widget.unit.attack,
            step: 1,
            min: Unit.DEFAULT_ATTACK,
            max: 10,
            onChange: (value) {
              setState(() {
                unit = unit.of(attack: value);
              });
            },
          ),
          FieldEditor(
            title: 'Range',
            value: widget.unit.range,
            min: Unit.DEFAULT_RANGE,
            step: 1,
            max: 3,
            onChange: (value) {
              setState(() {
                unit = unit.of(range: value);
              });
            },
          ),
          FieldEditor(
            title: 'Speed',
            value: widget.unit.speed,
            min: Unit.DEFAULT_SPEED,
            step: 1,
            max: 2,
            onChange: (value) {
              setState(() {
                unit = unit.of(speed: value);
              });
            },
          ),
          Text('Cost: ${unit.cost}'),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        FlatButton(
          onPressed: (unit.cost <= widget.availableCP)
              ? () {
                  Navigator.of(context).pop();
                  widget.onAccept(unit);
                }
              : null,
          child: Text(
            'ACCEPT',
            style: TextStyle(
                color: (unit.cost <= widget.availableCP)
                    ? widget.unit.player.color
                    : Colors.grey,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class FieldEditor extends StatefulWidget {
  final String title;
  final int value;
  final int step;
  final int min;
  final int max;
  final Function(int) onChange;

  const FieldEditor({
    @required this.title,
    @required this.value,
    @required this.step,
    @required this.min,
    @required this.max,
    @required this.onChange,
  });

  @override
  _FieldEditorState createState() => _FieldEditorState(value);
}

class _FieldEditorState extends State<FieldEditor> {
  int value = 0;

  _FieldEditorState(this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            RaisedButton(
              onPressed: _onDecrease,
              child: Text('-'),
            ),
            Expanded(child: Center(child: Text('$value'))),
            RaisedButton(
              onPressed: _onIncrease,
              child: Text('+'),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _onDecrease() {
    setState(() {
      if (value > widget.min) {
        value -= widget.step;
        widget.onChange(value);
      }
    });
  }

  void _onIncrease() {
    setState(() {
      if (value < widget.max) {
        value += widget.step;
        widget.onChange(value);
      }
    });
  }
}
