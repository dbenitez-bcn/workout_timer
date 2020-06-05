import 'package:flutter/material.dart';
import 'package:workout_timer/model/timer.dart';
import 'package:workout_timer/viewmodel/TimerVM.dart';

class MainScreen extends StatelessWidget {
  final TimerVM vm = TimerVM(timer: Timer(minutes: 0, seconds: 5));
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
                MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("00:30"),
                    onPressed: () {
                      this.vm.setTime(0, 30);
                    }),
                MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("01:00"),
                    onPressed: () {
                      this.vm.setTime(1, 20);
                    }),
                MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("05:00"),
                    onPressed: () {
                      this.vm.setTime(5, 20);
                    }),
              ],
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: StreamBuilder<Status>(
                    stream: this.vm.status,
                    initialData: Status.stopped,
                    builder: (context, snapshot) {
                      var timerino = Center(
                        child: StreamBuilder<String>(
                          stream: this.vm.start(),
                          initialData: "",
                          builder: (context, snapshot) {
                            return Text(snapshot.data,
                                style: Theme.of(context).textTheme.title);
                          },
                        ),
                      );

                      switch (snapshot.data) {
                        case Status.running:
                          return timerino;
                          break;
                        case Status.stopped:
                          return Text("Stopped");
                          break;
                        case Status.paused:
                          return Text("Paused");
                          break;
                        default:
                          return Text("Errorino");
                          break;
                      }
                    }),
              ),
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
