import 'package:flutter/material.dart';
import 'package:workout_timer/view/bloc/timer_bloc.dart';
import 'package:workout_timer/viewmodel/timer_vm.dart';

class EditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimerVM vm = TimerBloc.of(context).vm;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(),
          TimeSelector(),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            child: Text("Ok"),
            onPressed: () {
              vm.setWorkoutTime(1, 30);
              Navigator.of(context).pop();
            },
          )
        ],
      )
    );
  }
}

class TimeSelector extends StatelessWidget {
  Widget _buildMinutes(BuildContext context) {
    return PageView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: PageController(viewportFraction: 0.2),
      children:
      List<Widget>.generate(100, (index) => NumberDigit(value: index)),
    );
  }

  Widget _buildSeconds(BuildContext context) {
    return PageView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: PageController(viewportFraction: 0.2),
      children: List<Widget>.generate(60, (index) => NumberDigit(value: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: _buildMinutes(context),
          ),
          Flexible(
            flex: 4,
            child: Text(
              ":",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Flexible(
            child: _buildSeconds(context),
          ),
        ],
      ),
    );
  }
}


class NumberDigit extends StatelessWidget {
  final int value;

  NumberDigit({this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            "${(value).toString().padLeft(2, '0')}",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
