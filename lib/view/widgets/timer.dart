import 'package:flutter/material.dart';
import 'dart:math' as Math;

class TimerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = Math.min(size.height, size.width) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint body = Paint()..color = Colors.blue;
    canvas.drawCircle(center, radius, body);

    final smilePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    double progress = 0.25 * 2 * Math.pi;
    canvas.drawArc(
        Offset.zero & size, Math.pi * 1.5, progress, false, smilePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TimerClock extends StatelessWidget {
  const TimerClock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.width - 50,
      child: CustomPaint(
        painter: TimerPainter(),
      ),
    );
  }
}
