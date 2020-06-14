import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/workout_button.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class MainScreen extends StatelessWidget {
  final TimerVM vm = TimerVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: this.vm.load(),
        builder: (_, snapshot) {
          final isDone = snapshot.connectionState == ConnectionState.done;
          return AnimatedOpacity(
            opacity: isDone ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  StreamBuilder<Status>(
                    stream: this.vm.status,
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
                                    this.vm.setWorkoutTime(0, 30);
                                  }
                                : null,
                          ),
                          WorkoutButtonEnable(
                            text: "01:00",
                            onPressed: appStatus == Status.stopped
                                ? () {
                                    this.vm.setWorkoutTime(1, 0);
                                  }
                                : null,
                          ),
                          WorkoutButtonEnable(
                            text: "05:00",
                            onPressed: appStatus == Status.stopped
                                ? () {
                                    this.vm.setWorkoutTime(5, 0);
                                  }
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
