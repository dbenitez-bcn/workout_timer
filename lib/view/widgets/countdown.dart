import 'package:flutter/material.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';
import 'package:workout_timer/view/widgets/animated_countdown.dart';
import 'package:workout_timer/view/widgets/stopped_countdown.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class Countdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimerVM vm = TimerBloc.of(context).vm;

    return StreamBuilder<Status>(
      stream: vm.status,
      initialData: Status.stopped,
      builder: (context, snapshot) {
        if (snapshot.data == Status.stopped) {
          return StoppedCountdown();
        } else {
          return AnimatedCountdown(
            minutes: vm.getMinutes(),
            seconds: vm.getSeconds(),
          );
        }
      },
    );
  }
}
