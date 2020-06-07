import 'package:workout_timer/model/workout_timer.dart';
import 'dart:async';

class TimerVM {
  WorkoutTimer _model;
  WorkoutTimer _modelSnapshot;
  Status _status;
  String _lastTimeValue;

  StreamController<Status> _statusController;
  Stream<Status> get status => _statusController.stream;

  StreamController<String> _timeController;
  Stream<String> get time => _timeController.stream;

  TimerVM() {
    this._modelSnapshot = WorkoutTimer(minutes: 0, seconds: 5);
    this._clearModel();
    this._statusController = StreamController<Status>.broadcast();
    this._timeController = StreamController<String>();
    this._setStatus(Status.stopped);
    _run();
  }

  void stop() {
    _clearModel();
    _updateDisplayedTime(this._getSnapshotTime());
    this._setStatus(Status.stopped);
  }

  void play() {
    this._setStatus(Status.running);
  }

  void pause() {
    this._setStatus(Status.paused);
  }

  void setWorkoutTime(int minutes, int seconds) {
    this._modelSnapshot = WorkoutTimer(minutes: minutes, seconds: seconds);
    _clearModel();
    _updateDisplayedTime(_getSnapshotTime());
  }

  String getTime() {
    return _getFormatTime(this._model.minutes, this._model.seconds);
  }

  String getRound() {
    return this._model.round < 0 ? "∞" : "${this._model.round}";
  }

  void _run() {
    Timer.periodic(
      Duration(seconds: 1),
      (t) {
        _updateDisplayedTime(_getDisplayTime());
      },
    );
  }

  String _getDisplayTime() {
    switch (this._status) {
      case Status.running:
        return _getTimer();
        break;
      case Status.stopped:
        return _getSnapshotTime();
        break;
      case Status.paused:
        return getTime();
        break;
    }
    return "Error";
  }

  String _getSnapshotTime() {
    return _getFormatTime(
        this._modelSnapshot.minutes, this._modelSnapshot.seconds);
  }

  String _getFormatTime(int minutes, int seconds) {
    String time = "";

    time += _formatTime(minutes);
    time += ":";
    time += _formatTime(seconds);

    return time;
  }

  String _getTimer() {
    if (this._model.round != 0) {
      if (this._model.minutes > 0 && this._model.seconds == 0) {
        this._updateModel(this._model.minutes - 1, 59, this._model.round);
      } else if (this._model.seconds > 0) {
        this._updateModel(
            this._model.minutes, this._model.seconds - 1, this._model.round);
      } else {
        this._updateModel(this._modelSnapshot.minutes,
            this._modelSnapshot.seconds - 1, this._model.round - 1);
      }
      return _getFormatTime(this._model.minutes, this._model.seconds);
    } else {
      this.stop();
      return this._getSnapshotTime();
    }
  }

  void _setStatus(Status newStatus) {
    this._status = newStatus;
    this._statusController.add(this._status);
  }

  void _clearModel() {
    this._model = this._modelSnapshot;
  }

  String _formatTime(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  void _updateModel(int minutes, int seconds, int round) {
    this._model =
        WorkoutTimer(minutes: minutes, seconds: seconds, round: round);
  }

  void _updateDisplayedTime(String value) {
    if (value != this._lastTimeValue) {
      this._lastTimeValue = value;
      this._timeController.add(value);
    }
  }

  void dispose() {
    this._statusController.close();
    this._timeController.close();
  }
}

enum Status { running, stopped, paused }
