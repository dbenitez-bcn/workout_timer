import 'package:flutter/material.dart';
import 'dart:math' as Math;

class TimerPainter extends CustomPainter {
  final BuildContext context;
  final double percentage;

  TimerPainter({this.context, this.percentage});


  @override
  void paint(Canvas canvas, Size size) {

    final strokePaint = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    
    final bgStrokePaint = Paint()
      ..color = Colors.grey[300]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    double full = 2 * Math.pi;
    double progress = percentage * full;
    canvas.drawArc(
        Offset.zero & size, Math.pi * 1.5, full, false, bgStrokePaint);
    canvas.drawArc(
        Offset.zero & size, Math.pi * 1.5, progress, false, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TimerClock extends StatelessWidget {
  final double percentage;

  const TimerClock({
    Key key,
    this.percentage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.width - 50,
      child: AnimatedBuilder(
        child: CustomPaint(
          painter: TimerPainter(context: context, percentage: percentage),
        ),
      ),
    );
  }
}
