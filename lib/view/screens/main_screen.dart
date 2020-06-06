import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/time_displayer.dart';
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
            SizedBox(),
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: StreamBuilder<Status>(
                  stream: this.vm.status,
                  initialData: Status.stopped,
                  builder: (context, snapshot) {
                    switch (snapshot.data) {
                      case Status.running:
                        return StreamBuilder<String>(
                          stream: this.vm.start(),
                          initialData: this.vm.getTime(),
                          builder: (context, snapshot) {
                            return TimerDisplayer(time: snapshot.data);
                          },
                        );
                        break;
                      case Status.stopped:
                        return TimerDisplayer(time: this.vm.getTime());
                        break;
                      case Status.paused:
                        return Text("Paused");
                        break;
                      default:
                        return Text("Errorino");
                        break;
                    }
                  },
                ),
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
