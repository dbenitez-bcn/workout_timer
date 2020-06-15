import 'package:flutter/material.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';

import 'view/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerBloc(
      child: MaterialApp(
        title: 'Workout timer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}