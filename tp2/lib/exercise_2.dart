import 'package:flutter/material.dart';
import 'dart:math';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display image'),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            child: Image.network(
              'https://picsum.photos/512/1024',
              width: 400,
              fit: BoxFit.cover,
            ),
            width: 400.0,
            height: 200.0,
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
            transform: Matrix4.identity()
              //..rotateX(_currentSliderValueX)
              ..rotateZ(_currentSliderValue),
              //..rotateY(isChecked ? -pi : 0)
              //..scale(_currentScaleValue),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(8.0),
            Row(children: <Widget>[
              const Text('Apartment for rent!'),
              Slider(
                value: _currentSliderValue,
                min: 0,
                max: 1,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ]);
          ),
        ])));
  }
}
