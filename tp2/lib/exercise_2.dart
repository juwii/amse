import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValue_Z = 0;
  double _currentSliderValue_X = 0;
  double _currentSliderValue_S = 1;
  bool isChecked = false;
  bool animationRunning = false;
  bool rotate_X = true;
  bool rotate_Z = true;
  bool S = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display image'),
        ),
        body: Padding(
            padding: EdgeInsets.all(120),
            child: Column(children: <Widget>[
              FittedBox(
                alignment: Alignment.center,
                child: Container(
                  child: Transform(
                      origin: Offset(200, 100),
                      transform: Matrix4.identity()
                        ..rotateX(_currentSliderValue_X)
                        ..rotateZ(_currentSliderValue_Z)
                        ..rotateY(isChecked ? -pi : 0)
                        ..scale(_currentSliderValue_S),
                      child: Image.network(
                        'https://picsum.photos/512/1024',
                        width: 400,
                        fit: BoxFit.cover,
                      )),
                  width: 400.0,
                  height: 200.0,
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  height: 40,
                  width: 400.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text('RotateX : ' +
                        '(' +
                        _currentSliderValue_X.toStringAsFixed(2) +
                        ')'),
                    Slider(
                      value: _currentSliderValue_X,
                      min: 0,
                      max: pi,
                      label: _currentSliderValue_X.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue_X = value;
                        });
                      },
                    ),
                  ]),
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 400.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text('RotateZ : ' +
                        '(' +
                        _currentSliderValue_Z.toStringAsFixed(2) +
                        ')'),
                    Slider(
                      value: _currentSliderValue_Z,
                      min: 0,
                      max: 2 * pi,
                      label: _currentSliderValue_Z.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue_Z = value;
                        });
                      },
                    ),
                  ]),
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 400.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    const Text('Mirror :'),
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ]),
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 400.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text('Scale : ' +
                        '(' +
                        _currentSliderValue_S.toStringAsFixed(2) +
                        ')'),
                    Slider(
                      value: _currentSliderValue_S,
                      min: 0.5,
                      max: 3,
                      label: _currentSliderValue_S.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue_S = value;
                        });
                      },
                    ),
                  ]),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: FloatingActionButton(
                    child: Icon(animationRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded),
                    onPressed: () => {
                          setState(() {
                            animationRunning = !animationRunning;
                          }),
                          Timer.periodic(Duration(milliseconds: 50), animate),
                        }),
              ),
            ])));
  }

  void animate(Timer t) {
    setState(() {
      if (!animationRunning) {
        t.cancel();
        return;
      }

      if (rotate_X) {
        _currentSliderValue_X += pi / 100;
        if (_currentSliderValue_X > (pi - pi / 100)) rotate_X = false;
      } else {
        _currentSliderValue_X -= pi / 100;
        if (_currentSliderValue_X < (pi / 100)) rotate_X = true;
      }

      if (rotate_Z) {
        _currentSliderValue_Z += pi / 100;
        if (_currentSliderValue_Z > (2 * pi - pi / 100)) rotate_Z = false;
      } else {
        _currentSliderValue_Z -= pi / 100;
        if (_currentSliderValue_Z < pi / 100) rotate_Z = true;
      }

      if (_currentSliderValue_X > (pi / 2)) isChecked = true;
      if (_currentSliderValue_X < (pi / 2)) isChecked = false;

      if (S) {
        _currentSliderValue_S += 0.05;
        if (_currentSliderValue_S > (3 - 0.05)) S = false;
      } else {
        _currentSliderValue_S -= 0.05;
        if (_currentSliderValue_S < 0.55) S = true;
      }
    });
  }
}
