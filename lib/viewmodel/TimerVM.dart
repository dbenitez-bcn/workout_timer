import 'package:flutter/foundation.dart';
import 'package:workout_timer/model/timer.dart';
import 'dart:async';

class TimerVM {
  Timer timer;
  Status _status;

  TimerVM({@required this.timer}) {
    this._setStatus(Status.stopped);
  }

  StreamController<Status> _statusController = StreamController<Status>.broadcast();
  Stream<Status> get status => _statusController.stream;

  StreamController<String> _timeController = StreamController<String>();
  Stream<String> get time => _timeController.stream;

  String getTime(int foo) {
    String minutes;
    String seconds;
    if (this.timer.minutes < 10) {
      minutes = "0${this.timer.minutes}";
    } else {
      minutes = "${this.timer.minutes}";
    }

    if (foo < 10) {
      seconds = "0$foo";
    } else {
      seconds = "$foo";
    }
    return minutes + ":" + seconds;
  }

  void setTime(int minutes, int seconds) {
    this.timer = Timer(minutes: minutes, seconds: seconds);
  }

  void stop() {
    this._setStatus(Status.stopped);
  }

  void play() {
    this._setStatus(Status.running);
  }

  void pause() {
    this._setStatus(Status.paused);
  }

  void _setStatus(Status newStatus) {
    this._status = newStatus;
    this._statusController.add(this._status);
  }

  Stream<String> start() async* {
    for (int i = 0; i < this.timer.seconds; i++) {
      yield getTime(this.timer.seconds - i);
      await Future.delayed(Duration(seconds: 1));
    }

    yield "Time out!";

    await Future.delayed(Duration(seconds: 1));
    this._setStatus(Status.stopped);
  }

  void dispose() {
    this._statusController.close();
    this._timeController.close();
  }
}

enum Status { running, stopped, paused }
