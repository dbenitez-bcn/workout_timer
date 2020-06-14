import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayer/audioplayer.dart';
import 'package:workout_timer/model/workout_timer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:workout_timer/model/workout_timer_dto.dart';

class TimerVM {
  String _goPath;
  WorkoutTimer _model;
  Status _status;
  AudioPlayer _audioPlugin;

  StreamController<Status> _statusController;
  Stream<Status> get status => _statusController.stream;

  StreamController<WorkoutTimerDTO> _workoutTimerController;
  Stream<WorkoutTimerDTO> get workoutTimer => _workoutTimerController.stream;

  TimerVM() {
    this._model = WorkoutTimer(minutes: 0, seconds: 5);
    this._statusController = StreamController<Status>.broadcast();
    this._workoutTimerController = StreamController<WorkoutTimerDTO>.broadcast();
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
    this._setStatus(Status.stopped);
  }

  void play() {
    this._setStatus(Status.running);
  }

  void pause() {
    this._setStatus(Status.paused);
  }

  void setWorkoutTime(int minutes, int seconds) {
    this._model = WorkoutTimer(minutes: minutes, seconds: seconds);
    this._workoutTimerController.add(WorkoutTimerDTO(minutes, seconds));
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

  void _setStatus(Status newStatus) {
    this._status = newStatus;
    this._statusController.add(this._status);
  }

  Future<void> _writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void dispose() {
    this._statusController.close();
    this._workoutTimerController.close();
  }
}

enum Status { running, stopped, paused }
