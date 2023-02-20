import 'package:flutter/material.dart';
import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display image'),
        ),
        body: Center(
          child: Image.network(
            'https://picsum.photos/512/1024',
            width: 350,
            fit: BoxFit.cover,
          ),
        ));
  }
}
