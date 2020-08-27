import 'package:flutter/material.dart';

class MultipleUnitsWidget extends StatelessWidget {
  const MultipleUnitsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: CustomPaint(
        painter: MultiplePainter(),
        child: Container(),
      ),
    );
  }
}

class MultiplePainter extends CustomPainter {
  const MultiplePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0, 0, size.width * 0.7, size.height * 0.7);
    canvas.drawRect(rect, Paint()..color = Colors.yellow);

    final Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.green);

    canvas.drawCircle(size.center(Offset(size.width / 3, size.height / 3)),
        size.width / 3, Paint()..color = Colors.deepPurple);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
