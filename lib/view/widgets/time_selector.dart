import 'package:flutter/material.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';
import 'package:workout_timer/view/widgets/workout_button.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';



class TimeSelector extends StatelessWidget {
  const TimeSelector({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerVM vm = TimerBloc.of(context).vm;

    return StreamBuilder<Status>(
      stream: vm.status,
      initialData: Status.stopped,
      builder: (context, snapshot) {
        final appStatus = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            WorkoutButtonEnable(
              text: "00:30",
              onPressed: appStatus == Status.stopped
                  ? () {
                vm.setWorkoutTime(0, 30);
              }
                  : null,
            ),
            WorkoutButtonEnable(
              text: "01:00",
              onPressed: appStatus == Status.stopped
                  ? () {
                vm.setWorkoutTime(1, 0);
              }
                  : null,
            ),
            WorkoutButtonEnable(
              text: "05:00",
              onPressed: appStatus == Status.stopped
                  ? () {
                vm.setWorkoutTime(5, 0);
              }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
