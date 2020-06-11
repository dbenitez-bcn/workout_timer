import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/timer.dart';

class TimerDisplayer extends StatelessWidget {
  const TimerDisplayer({
    Key key,
    @required this.time,
    @required this.round,
    @required this.percentage,
  }) : super(key: key);

  final String time;
  final String round;
  final double percentage;

  Widget _buildTimer(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          this.time,
          style: TextStyle(fontSize: 48),
        ),
        Text(
          this.round,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return SizedBox(
      width: 300,
      height: 400,
      child: Container(
        color: Colors.red,
        child: TimerClock(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        TimerClock(percentage: percentage),
        _buildTimer(context),
      ],
    );
  }
}
