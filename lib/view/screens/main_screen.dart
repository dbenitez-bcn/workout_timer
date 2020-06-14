import 'package:flutter/material.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';
import 'package:workout_timer/view/widgets/main_screen_builder.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class MainScreen extends StatelessWidget {
  final TimerVM vm = TimerVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TimerBloc(
          child: MainScreenBuilder(),
        ),
      ),
    );
  }
}
