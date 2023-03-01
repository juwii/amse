import 'package:flutter/material.dart';

class DisplayGridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grid of colored boxes'),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[100],
              child: const Text("Tile 1"),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[200],
              child: const Text('Tile 2'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[300],
              child: const Text('Tile 3'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[400],
              child: const Text('Tile 4'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[500],
              child: const Text('Tile 5'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[600],
              child: const Text('Tile 6'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[700],
              child: const Text('Tile 7'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[800],
              child: const Text('Tile 8'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.teal[900],
              child: const Text('Tile 9'),
            ),
          ],
        ),);
  }
}