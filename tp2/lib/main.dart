import 'package:flutter/material.dart';
import 'exercise_1.dart' as Exercice_1;
import 'exercise_2.dart' as Exercice_2;
import 'exercise_4.dart' as Exercice_4;
import 'exercise_5a.dart' as Exercice_5a;
import 'exercise_5b.dart' as Exercice_5b;
import 'exercise_5c.dart' as Exercice_5c;
import 'exercise_6.dart' as Exercice_6;

void main() => runApp(TP2());

class TP2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TP2_Exercices());
  }
}

class Exercice {
  final String title;
  final String subtitle;
  final WidgetBuilder buildFunc;

  const Exercice(
      {required this.title, required this.subtitle, required this.buildFunc});
}

List Exercices = [
  Exercice(
      title: 'Exercice 1',
      subtitle: 'Display an image',
      buildFunc: (context) => Exercice_1.DisplayImageWidget()),
  Exercice(
      title: 'Exercice 2',
      subtitle: 'Transform an image',
      buildFunc: (context) => Exercice_2.SliderExample()),
  Exercice(
      title: 'Exercice 3',
      subtitle: 'Printing of a "tuile"',
      buildFunc: (context) => Exercice_4.DisplayTileWidget()),
  Exercice(
      title: 'Exercice 4',
      subtitle: 'Printing of a "tuile"',
      buildFunc: (context) => Exercice_4.DisplayTileWidget()),
  Exercice(
      title: 'Exercice 5a',
      subtitle: 'Grid of colored boxes',
      buildFunc: (context) => Exercice_5a.DisplayGridViewWidget()),
  Exercice(
      title: 'Exercice 5b',
      subtitle: 'Fixed Grid of CroppedImage',
      buildFunc: (context) => Exercice_5b.DisplayGridCroppedImageWidget()),
  Exercice(
      title: 'Exercice 5c',
      subtitle: 'Configure the CroppedImage',
      buildFunc: (context) => Exercice_5c.configureCropImage()),
  Exercice(
      title: 'Exercice 6',
      subtitle: 'Tile animation',
      buildFunc: (context) => Exercice_6.PositionedTiles())
];

class TP2_Exercices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TP2'),
        ),
        body: ListView.builder(
            itemCount: Exercices.length,
            itemBuilder: (context, index) {
              var Exercice = Exercices[index];
              return Card(
                  child: ListTile(
                      title: Text(Exercice.title),
                      subtitle: Text(Exercice.subtitle),
                      trailing: Icon(Icons.play_arrow_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: Exercice.buildFunc),
                        );
                      }));
            }));
  }
}
