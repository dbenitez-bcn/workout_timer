import 'package:flutter/foundation.dart';

class Timer {
  int minutes;
  int seconds;

  Timer({@required this.minutes, @required this.seconds})
      : assert(minutes <= 99),
        assert(seconds < 60);
}
