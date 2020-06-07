import 'package:flutter/material.dart';

class TimerDisplayer extends StatelessWidget {
  const TimerDisplayer({
    Key key,
    @required this.time,
    @required this.round,
  }) : super(key: key);

  final String time;
  final String round;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          this.time,
          style: TextStyle(fontSize: 48),
        ),
        Text(
          this.round,
          style: Theme.of(context).textTheme.title,
        ),
      ],
    );
  }
}
