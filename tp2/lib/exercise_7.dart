import 'package:flutter/material.dart';
import 'dart:math';
import 'exercise_4.dart';
import 'exercise_5c.dart' as exercise_5c;
import 'exercise_5b.dart' as exercise_5b;
import 'exercise_6b.dart' as exercise_6b;

class taquin extends StatefulWidget {
  @override
  State<taquin> createState() => _taquinState();
}

class _taquinState extends State<taquin> {
  String textButtonGame = "Start Game";
  var taquinBoard;
  Image img = Image.asset("assets/images/avatar.jpg");  // default picture for taquin board
  var numberCrops = 4;  // default number of crops
  bool gameStarted = false;
  Color buttonsColor = Colors.blue;
  late exercise_5b.croppedImage croppedImgConf;
  List<List<Tile>>? listCroppedImage;
  List<List<Tile>>? listCroppedImageMixed;
  var coordFirstCard = [0, 0];

  List<List<Tile>>? mixTiles(List<List<Tile>>? listCroppedImage, int difficulty) {
    setState(() {
    int i = 0;
    listCroppedImageMixed = [...listCroppedImage!];
    // generates random coordinates of a tile
    Random random = new Random();
    int x = random.nextInt(listCroppedImageMixed!.length);
    int y = random.nextInt(listCroppedImageMixed!.length);
    while(i < difficulty) {
      Random random2 = new Random();
      // generates random moving
      int j = random2.nextInt(1);  // 0 : x moving, 1: y moving
      int d;
      d = random2.nextInt(2);   // moving = j + d
      if(d == 0) {d = -1;}
      if(j == 0 && (x+d)<listCroppedImageMixed!.length && (x+d)>=0) {
        var temp = listCroppedImageMixed![x][y];
        listCroppedImageMixed![x][y] =
            listCroppedImageMixed![x + d][y];
        listCroppedImageMixed![x + d][y] = temp;
        x = x + d;
      } else if ((y+d)<listCroppedImageMixed!.length && (y+d)>=0){
        var temp = listCroppedImageMixed![x][y];
        listCroppedImageMixed![x][y] =
            listCroppedImageMixed![x][y + d];
        listCroppedImageMixed![x][y + d] = temp;
        y = y + d;
      }
      i++;
    }
    coordFirstCard = [x, y];
    });
  }

  @override
  void initState() {
    croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
        1 / numberCrops,
        1 / numberCrops,
        listCroppedImage);
    listCroppedImage = croppedImgConf.listCroppedImage;
    taquinBoard = exercise_6b.moveCropImage(numberCrops, img, gameStarted, listCroppedImage, coordFirstCard, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Taquin game'),
        ),
      body: Column(
        children: [
          Container(
            height: 400,
            child: taquinBoard
          ),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                    child: FloatingActionButton(
                      heroTag: "minus",
                      backgroundColor: buttonsColor,
                      child: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if(!gameStarted && taquinBoard.getNumberCrops <= 10 && taquinBoard.getNumberCrops >= 3) {
                              var oldTaquin = taquinBoard;
                              exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
                              1 / (oldTaquin.getNumberCrops-1),
                              1 / (oldTaquin.getNumberCrops-1),
                              listCroppedImage);
                              listCroppedImage = croppedImgConf.listCroppedImage;
                              taquinBoard = new exercise_6b.moveCropImage(oldTaquin.getNumberCrops-1, img, false, listCroppedImage, coordFirstCard, false);
                              listCroppedImage = taquinBoard.listCroppedImage;
                          }
                        }
                        );
                      },
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(30),
                  ),
                  Container(
                    height: 100,
                    child: FloatingActionButton(
                      heroTag: "more",
                      backgroundColor: buttonsColor,
                      child: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                         if(!gameStarted && taquinBoard.getNumberCrops <= 9 && taquinBoard.getNumberCrops >= 2) {
                             var oldTaquin = taquinBoard;
                             exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
                              1 / (oldTaquin.getNumberCrops+1),
                              1 / (oldTaquin.getNumberCrops+1),
                              listCroppedImage);
                              listCroppedImage = croppedImgConf.listCroppedImage;
                             taquinBoard = new exercise_6b.moveCropImage(oldTaquin.getNumberCrops+1, img, false, listCroppedImage, coordFirstCard, false);
                             listCroppedImage = taquinBoard.listCroppedImage;
                          }
                        }
                        );
                      },
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(30),
                  ),
            ],
          ),
          TextButton(
            onPressed: (){
              setState(() {
                if(textButtonGame == "Start Game") {
                  textButtonGame = "Stop Game";
                  gameStarted = true;
                  mixTiles(taquinBoard.listCroppedImage, 20);
                  var oldTaquin = taquinBoard;
                  taquinBoard = exercise_6b.moveCropImage(oldTaquin.getNumberCrops, oldTaquin.img, gameStarted, listCroppedImageMixed, coordFirstCard, true);
                  buttonsColor = Colors.grey;
                } else {
                  textButtonGame = "Start Game";
                  gameStarted = false;
                  coordFirstCard = [0,0];
                  exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
                      1 / 4,
                      1 / 4,
                      listCroppedImage);
                      listCroppedImage = croppedImgConf.listCroppedImage;
                  taquinBoard = exercise_6b.moveCropImage(numberCrops, img, gameStarted, croppedImgConf.listCroppedImage, coordFirstCard, true);
                  buttonsColor = Colors.blue;
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