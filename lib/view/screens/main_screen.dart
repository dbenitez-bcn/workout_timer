import 'package:flutter/material.dart';
import 'package:workout_timer/view/widgets/main_screen_builder.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainScreenBuilder(),
      ),
    );
  }
}
