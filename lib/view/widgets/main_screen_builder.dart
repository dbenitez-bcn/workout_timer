import 'package:flutter/material.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';
import 'package:workout_timer/view/widgets/countdown.dart';
import 'package:workout_timer/view/widgets/time_selector.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class MainScreenBuilder extends StatelessWidget {
  const MainScreenBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerVM vm = TimerBloc.of(context).vm;

    return FutureBuilder<void>(
      future: vm.load(),
      builder: (_, snapshot) {
        final isDone = snapshot.connectionState == ConnectionState.done;
        return AnimatedOpacity(
          opacity: isDone ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TimeSelector(),
                  Countdown(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
