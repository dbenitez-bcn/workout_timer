import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/time_displayer.dart';
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
            child: StreamBuilder(
              stream: this.vm.status,
              initialData: Status.stopped,
              builder: (context, snapshot) {
                final appStatus = snapshot.data;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
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
                      ),
                      StreamBuilder<String>(
                        stream: this.vm.time,
                        initialData: this.vm.getTime(),
                        builder: (context, snapshot) {
                          return TimerDisplayer(
                            time: snapshot.data,
                            round: this.vm.getRound(),
                            percentage: this.vm.getPercentage(),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: Text("Stop"),
                            onPressed: appStatus != Status.stopped
                                ? () {
                                    this.vm.stop();
                                  }
                                : null,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                                appStatus == Status.running ? "Pause" : "Play"),
                            onPressed: () {
                              if (appStatus == Status.running) {
                                this.vm.pause();
                              } else {
                                this.vm.play();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
