import 'package:flutter/material.dart';
import 'exercise_4.dart';
import 'exercise_5c.dart' as exercise_5c;

class taquin extends StatefulWidget {
  @override
  State<taquin> createState() => _taquinState();
}

class _taquinState extends State<taquin> {
  String textButtonGame = "Start Game";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Taquin game'),
        ),
      body: Column(
        children: [
          Container(child: exercise_5c.configureCropImage(img: Image.asset("assets/images/avatar.jpg"), numberCrops: 4)),
          TextButton(
            onPressed: (){
              setState(() {
                if(textButtonGame == "Start Game") {
                  textButtonGame = "Stop Game";
                } else {
                  textButtonGame = "Start Game";
                }
              });
            }, 
            child: Text(textButtonGame),
            )
        ],
    ),
    );
  }
}