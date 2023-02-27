import 'package:flutter/material.dart';
import 'exercise_1.dart' as Exercice_1;
import 'exercise_2.dart' as Exercice_2;
import 'exercise_4.dart' as Exercice_4;

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
      buildFunc: (context) => Exercice_4.DisplayTileWidget())
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
