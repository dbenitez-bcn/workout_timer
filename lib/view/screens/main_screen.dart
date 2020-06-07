import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/time_displayer.dart';
import 'package:workout_timer/view/widgets/workout_button.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class MainScreen extends StatelessWidget {
  final TimerVM vm = TimerVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                WorkoutButtonEnable(
                  text: "00:30",
                  onPressed: () {
                    this.vm.setWorkoutTime(0, 30);
                  },
                ),
                WorkoutButtonEnable(
                  text: "01:00",
                  onPressed: () {
                    this.vm.setWorkoutTime(1, 0);
                  },
                ),
                WorkoutButtonEnable(
                  text: "05:00",
                  onPressed: () {
                    this.vm.setWorkoutTime(5, 0);
                  },
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
                );
              },
            ),
            StreamBuilder<Status>(
              stream: this.vm.status,
              initialData: Status.stopped,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Stop"),
                      onPressed: snapshot.data != Status.stopped
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
                          snapshot.data == Status.running ? "Pause" : "Play"),
                      onPressed: () {
                        if (snapshot.data == Status.running) {
                          this.vm.pause();
                        } else {
                          this.vm.play();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
