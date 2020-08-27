import 'package:cards_game/models/unit.dart';
import 'package:cards_game/models/unit_type.dart';
import 'package:flutter/material.dart';

class UnitWidget extends StatelessWidget {
  final Unit unit;
  final bool showStats;
  final double padding;

  UnitWidget({
    @required this.unit,
    this.showStats = true,
    this.padding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: CustomPaint(
        painter: _painter(unit),
        child: Container(),
      ),
    );
  }

  CustomPainter _painter(Unit unit) {
    switch (unit.type) {
      case UnitType.circle:
        return CirclePainter(unit: unit, showHealth: showStats);

      case UnitType.triangle:
        return TrianglePainter(unit: unit, showHealth: showStats);

      case UnitType.square:
        return SquarePainter(unit: unit, showHealth: showStats);

      default:
        return null;
    }
  }
}

class CirclePainter extends BasePainter {
  CirclePainter({@required Unit unit, @required bool showHealth})
      : super(unit: unit, showStats: showHealth);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(size.center(Offset(0, 0)), size.width / 2, painter);

    super.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TrianglePainter extends BasePainter {
  TrianglePainter({@required Unit unit, @required bool showHealth})
      : super(unit: unit, showStats: showHealth);

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);

    super.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SquarePainter extends BasePainter {
  SquarePainter({@required Unit unit, @required bool showHealth})
      : super(unit: unit, showStats: showHealth);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);

    canvas.drawRect(rect, painter);

    super.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BasePainter extends CustomPainter {
  final Unit unit;
  final bool showStats;
  final Paint painter;

  BasePainter({
    @required this.unit,
    @required this.showStats,
  }) : painter = Paint()..color = unit.player.color;

  @override
  void paint(Canvas canvas, Size size) {
    if (showStats) {
      _drawStat(unit.health, canvas, size, 0, 0);
      _drawStat(unit.attack, canvas, size, 1, 0);
      _drawStat(unit.range, canvas, size, 0, 1);
      _drawStat(unit.speed, canvas, size, 1, 1);
    }
  }

  void _drawStat(int value, Canvas canvas, Size size, int x, int y) {
    final TextSpan span = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 10),
      text: '$value',
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    canvas.drawCircle(
      Offset(
        (size.width * x) + ((x == 0) ? 5 : -5),
        (size.height * y) + ((y == 0) ? 5 : -5),
      ),
      10,
      Paint()..color = Colors.green,
    );

    tp.paint(
      canvas,
      Offset(
        (size.width - tp.width) * x,
        (size.height - tp.height) * y,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
