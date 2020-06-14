import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayer/audioplayer.dart';
import 'package:workout_timer/model/workout_timer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class TimerVM {
  String _goPath;
  WorkoutTimer _model;
  WorkoutTimer _modelSnapshot;
  Status _status;
  AudioPlayer _audioPlugin;

  StreamController<Status> _statusController;
  Stream<Status> get status => _statusController.stream;

  TimerVM() {
    this._modelSnapshot = WorkoutTimer(minutes: 0, seconds: 5);
    this._clearModel();
    this._statusController = StreamController<Status>();
    this._audioPlugin = AudioPlayer();
  }

  Future<void> load() async {
    final filename = 'go.mp3';
    var bytes = await rootBundle.load("assets/go.mp3");
    String dir = (await getApplicationDocumentsDirectory()).path;
    this._goPath = '$dir/$filename';
    await _writeToFile(bytes, '$dir/$filename');
  }

  void stop() {
    _clearModel();
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
  }

  String getTime() {
    return _getFormatTime(this._model.minutes, this._model.seconds);
  }

  String getRound() {
    return this._model.round < 0 ? "∞" : "${this._model.round}";
  }

  int getMinutes() {
    return this._model.minutes;
  }

  int getSeconds() {
    return this._model.seconds;
  }

  double getPercentage() {
    var foo = ((this._getTimeInSeconds(this._model) * 100) /
            this._getTimeInSeconds(this._modelSnapshot)) *
        0.01;
    return 1.0 - foo;
  }

  int _getTimeInSeconds(WorkoutTimer workoutTimer) {
    return (60 * workoutTimer.minutes) + workoutTimer.seconds;
  }

  String _getFormatTime(int minutes, int seconds) {
    String time = "";

    time += _formatTime(minutes);
    time += ":";
    time += _formatTime(seconds);

    return time;
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

  Future<void> _writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void dispose() {
    this._statusController.close();
  }
}

enum Status { running, stopped, paused }
