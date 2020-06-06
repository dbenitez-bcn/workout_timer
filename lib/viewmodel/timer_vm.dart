import 'package:flutter/foundation.dart';
import 'package:workout_timer/model/workout_timer.dart';
import 'dart:async';

class TimerVM {
  WorkoutTimer model;
  Status _status;

  StreamController<Status> _statusController;
  Stream<Status> get status => _statusController.stream;

  StreamController<String> _timeController;
  Stream<String> get time => _timeController.stream;

  TimerVM() {
    this.model = WorkoutTimer(minutes: 0, seconds: 50);
    this._statusController = StreamController<Status>.broadcast();
    this._timeController = StreamController<String>();
    this._setStatus(Status.stopped);
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

  String getTime() {
    return getFormatTime(this.model.minutes, this.model.seconds);
  }
  
  String getFormatTime(int minutes, int seconds) {
    String time = "";

    time += formatTime(minutes);
    time += ":";
    time += formatTime(seconds);

    return time;
  }

  String formatTime(int value) {
    return value < 10 ? "0$value" : "$value";
  }
  
  Stream<String> start() async* {
    for (int i = 0; i < this.model.seconds; i++) {
      var foo = getFormatTime(this.model.minutes, this.model.seconds - i);
      yield foo;
      await Future.delayed(Duration(seconds: 1));
    }

    yield "Time out!";

    await Future.delayed(Duration(seconds: 1));
    this._setStatus(Status.stopped);
  }

  /*void setTime(int minutes, int seconds) {
    this.timer = Timer(minutes: minutes, seconds: seconds);
  }

*/

  void dispose() {
    this._statusController.close();
    this._timeController.close();
  }
}

enum Status { running, stopped, paused }
