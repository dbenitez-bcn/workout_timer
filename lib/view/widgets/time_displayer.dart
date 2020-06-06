import 'package:flutter/material.dart';

class TimerDisplayer extends StatelessWidget {
  const TimerDisplayer({
    Key key,
    @required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.time,
      style: Theme.of(context).textTheme.title,
    );
  }
}
