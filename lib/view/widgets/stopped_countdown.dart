import 'package:flutter/material.dart';
import 'package:workout_timer/model/workout_timer_dto.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class StoppedCountdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TimerVM vm = TimerBloc.of(context).vm;

    return StreamBuilder<WorkoutTimerDTO>(
      stream: vm.workoutTimer,
      initialData: WorkoutTimerDTO(vm.getMinutes(), vm.getSeconds()),
      builder: (context, snapshot) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CustomPaint(
                          painter: TimerPainter(),
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Text(
                          '${(snapshot.data.minutes).toString().padLeft(2, '0')}:${(snapshot.data.seconds).toString().padLeft(2, '0')}',
                          style: themeData.textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: vm.play,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TimerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey[300]
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return true;
  }
}
