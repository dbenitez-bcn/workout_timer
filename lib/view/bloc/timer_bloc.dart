import 'package:flutter/material.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class TimerBloc extends InheritedWidget {
  final TimerVM vm = TimerVM();
  final Widget child;

  TimerBloc({this.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TimerBloc of(BuildContext context){
    Theme.of(context);
    return context.dependOnInheritedWidgetOfExactType<TimerBloc>();
  }

}