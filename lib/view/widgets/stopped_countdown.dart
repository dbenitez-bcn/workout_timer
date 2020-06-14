import 'package:flutter/material.dart';

class StoppedCountdown extends StatelessWidget {
  final int minutes;
  final int seconds;

  StoppedCountdown({@required this.minutes, @required this.seconds});

  String get timerString {
    return '${(this.minutes).toString().padLeft(2, '0')}:${(this.seconds).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(),
          Align(
            alignment: FractionalOffset.center,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: CustomPaint(
                      painter: TimerPainter(),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    child: Text(
                      timerString,
                      style: themeData.textTheme.headline1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("call play");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey[300]
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return true;
  }
}
