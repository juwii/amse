import 'package:flutter/material.dart';
import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _value = 0.0;
    return Scaffold(
        appBar: AppBar(
          title: Text('Display image'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.network(
                  'https://picsum.photos/512/1024',
                  width: 400,
                  fit: BoxFit.cover,
                ),
                transform: Matrix4.rotationZ(0.1),
                width: 400.0,
                height: 200.0,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Container(
                child: Slider(
                  min: 0,
                  max: 100,
                  value: _value,
                  onChanged: (value) {
                    _value = value;
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
