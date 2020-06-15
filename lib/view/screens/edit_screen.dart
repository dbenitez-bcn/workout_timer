import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  final Function(int, int) onSave;

  EditScreen({this.onSave});

  int seconds = 0;
  int minutes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(),
        TimeSelector(
          setMinutes: setMinutes,
          setSeconds: setSeconds,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: Text("Ok"),
          onPressed: () {
            this.onSave(this.minutes, this.seconds);
            Navigator.of(context).pop();
          },
        )
      ],
    ));
  }

  void setMinutes(value) {
    this.minutes = value;
  }

  void setSeconds(value) {
    this.seconds = value;
  }
}

class TimeSelector extends StatelessWidget {
  final ValueChanged<int> setMinutes;
  final ValueChanged<int> setSeconds;

  TimeSelector({this.setMinutes, this.setSeconds});

  Widget _buildMinutes(BuildContext context) {
    return PageView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: PageController(viewportFraction: 0.2),
      onPageChanged: this.setMinutes,
      children:
          List<Widget>.generate(100, (index) => NumberDigit(value: index)),
    );
  }

  Widget _buildSeconds(BuildContext context) {
    return PageView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: PageController(viewportFraction: 0.2),
      onPageChanged: this.setSeconds,
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
