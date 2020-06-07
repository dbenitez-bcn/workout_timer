import 'package:flutter/material.dart';

class WorkoutButtonActive extends StatelessWidget {
  final String text;


  WorkoutButtonActive({this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

class WorkoutButtonEnable extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;


  WorkoutButtonEnable({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide()
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class WorkoutButtonDisable extends StatelessWidget {
  final String text;


  WorkoutButtonDisable({this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: null,
      child: Text(text),
    );
  }
}
