import 'package:cards_game/models/unit.dart';
import 'package:cards_game/models/unit_type.dart';
import 'package:flutter/material.dart';

class UnitWidget extends StatelessWidget {
  final Unit unit;

  UnitWidget({@required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomPaint(
        painter: _painter(unit),
        child: Container(),
      ),
    );
  }

  CustomPainter _painter(Unit unit) {
    switch (unit.type) {
      case UnitType.circle:
        return CirclePainter(unit: unit);

      case UnitType.triangle:
        return TrianglePainter(unit: unit);

      case UnitType.square:
        return SquarePainter(unit: unit);

      default:
        return null;
    }
  }
}

class CirclePainter extends BasePainter {
  CirclePainter({@required Unit unit}) : super(unit: unit);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(size.center(Offset(0, 0)), size.width / 2, painter);

    super.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TrianglePainter extends BasePainter {
  TrianglePainter({@required Unit unit}) : super(unit: unit);

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
  SquarePainter({@required Unit unit}) : super(unit: unit);

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
  final Paint painter;

  BasePainter({@required this.unit})
      : painter = Paint()..color = unit.player.color;

  @override
  void paint(Canvas canvas, Size size) {
    final TextSpan span = TextSpan(
      style: TextStyle(color: Colors.white),
      text: '${unit.health}',
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(
        (size.width - tp.width) * 0.5,
        (size.height - tp.height) * 0.65,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
