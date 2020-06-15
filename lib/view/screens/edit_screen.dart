import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/time_selector.dart';

class EditScreen extends StatelessWidget {
  final Function(int, int) onSave;

  EditScreen({this.onSave});

  int seconds = 0;
  int minutes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(),
          TimeSelector(
            setMinutes: setMinutes,
            setSeconds: setSeconds,
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            child: Text("Ok"),
            onPressed: () {
              this.onSave(this.minutes, this.seconds);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void setMinutes(value) {
    this.minutes = value;
  }

  void setSeconds(value) {
    this.seconds = value;
  }
}
