import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCountdown extends StatefulWidget {
  final int minutes;
  final int seconds;

  AnimatedCountdown({@required this.minutes, @required this.seconds});

  @override
  AnimatedCountdownState createState() => AnimatedCountdownState();
}

class AnimatedCountdownState extends State<AnimatedCountdown>
    with TickerProviderStateMixin {

  AnimationController _controller;
  bool _isPlaying = false;
  bool _goPlayed = false;

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    if (duration.inSeconds == 2 && !_goPlayed) {
      this._goPlayed = true;
      // TODO: Play song here!
      print("Playing song!");
    }
    return '${(duration.inMinutes).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _toggleStatus() {
    setState(() {
      this._isPlaying ? this._stop() : this._play();
    });
  }

  void _play() {
    this._isPlaying = true;
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void _stop() {
    this._isPlaying = false;
    _controller.stop(canceled: true);
  }

  void _restart() {
    this._goPlayed = false;
    _play();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: widget.minutes, seconds: widget.seconds),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _restart();
      }
    });
    _play();
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
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                          painter: TimerPainter(
                            animation: _controller,
                            backgroundColor: Colors.grey[300],
                            color: themeData.indicatorColor,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          timerString,
                          style: themeData.textTheme.headline1,
                        );
                      },
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
                  this._isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: _toggleStatus,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
