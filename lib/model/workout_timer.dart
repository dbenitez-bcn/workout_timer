import 'package:flutter/foundation.dart';

class WorkoutTimer {
  int minutes;
  int seconds;
  int round;

  WorkoutTimer({@required this.minutes, @required this.seconds, this.round = -1})
      : assert(minutes <= 99),
        assert(seconds < 60);
}
