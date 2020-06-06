import 'package:flutter/foundation.dart';

class WorkoutTimer {
  int minutes;
  int seconds;

  WorkoutTimer({@required this.minutes, @required this.seconds})
      : assert(minutes <= 99),
        assert(seconds < 60);
}
