import 'package:flutter/foundation.dart';
import 'package:workout_timer/model/workout_timer.dart';
import 'dart:async';

class TimerVM {
  WorkoutTimer model;
  WorkoutTimer modelSnapshot;
  Status _status;
  String lastTimeValue;

  StreamController<Status> _statusController;
  Stream<Status> get status => _statusController.stream;

  StreamController<String> _timeController;
  Stream<String> get time => _timeController.stream;

  TimerVM() {
    this.modelSnapshot = WorkoutTimer(minutes: 0, seconds: 5);
    this._clearModel();
    this._statusController = StreamController<Status>.broadcast();
    this._timeController = StreamController<String>();
    this._setStatus(Status.stopped);
    _run();
  }

  void stop() {
    _clearModel();
    _sinkTime(this.getSnapshotTime());
    this._setStatus(Status.stopped);
  }

  void play() {
    this._setStatus(Status.running);
  }

  void pause() {
    this._setStatus(Status.paused);
  }

  String getSnapshotTime() {
    return _getFormatTime(
        this.modelSnapshot.minutes, this.modelSnapshot.seconds);
  }

  String getTime() {
    return _getFormatTime(this.model.minutes, this.model.seconds);
  }

  void _run() {
    Timer.periodic(
      Duration(seconds: 1),
      (t) {
        _sinkTime(_getDisplayTime());
      },
    );
  }

  String _getDisplayTime() {
    switch (this._status) {
      case Status.running:
        return _getTimer();
        break;
      case Status.stopped:
        return getSnapshotTime();
        break;
      case Status.paused:
        return getTime();
        break;
    }
  }

  void _setStatus(Status newStatus) {
    this._status = newStatus;
    this._statusController.add(this._status);
  }

  void _clearModel() {
    this.model = this.modelSnapshot;
  }

  String _getFormatTime(int minutes, int seconds) {
    String time = "";

    time += _formatTime(minutes);
    time += ":";
    time += _formatTime(seconds);

    return time;
  }

  String _formatTime(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  String _getTimer() {
    if (this.model.seconds > 0) {
      this._updateModel(this.model.minutes, this.model.seconds - 1);
      return _getFormatTime(this.model.minutes, this.model.seconds);
    } else {
      this.stop();
      return this.getSnapshotTime();
    }
  }

  void _updateModel(int minutes, int seconds) {
    this.model = WorkoutTimer(minutes: minutes, seconds: seconds);
  }

  void _sinkTime(String value) {
    if (value != this.lastTimeValue) {
      this.lastTimeValue = value;
      this._timeController.add(value);
    }
  }

  void dispose() {
    this._statusController.close();
    this._timeController.close();
  }
}

enum Status { running, stopped, paused }
