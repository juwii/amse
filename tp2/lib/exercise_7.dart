//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'exercise_4.dart';
import 'exercise_5c.dart' as exercise_5c;
import 'exercise_5b.dart' as exercise_5b;
import 'exercise_6b.dart' as exercise_6b;

class taquin extends StatefulWidget {
  @override
  State<taquin> createState() => _taquinState();
}

class _taquinState extends State<taquin> {
  
  var uuid = Uuid();
  var list_id;
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
  var parser = EmojiParser();
  var difficulty = 20;
  var list_difficulty = [20, 70, 1000];
  var dropdownvalue = Emoji('baby','U+1F476');
  var difficulty_smileys = [    
    Emoji('baby','U+1F476'),
    Emoji('sweat', 'U+1F974'),
    Emoji('scream', 'U+1F631'),
  ];

  // Function to handle selecting an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      img = Image.file(File(pickedImage!.path));
    });
  }

  // Function to handle taking a picture with the camera
  Future<void> _takePicture() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      img = Image.file(File(pickedImage!.path));
    });
  }

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
      Random random3 = new Random();
      int d = 0;
      while(d == 0){d = random3.nextInt(3)-1;}   // moving = j + d
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
    list_id = List.generate((numberCrops).floor(), (i) => List.generate((numberCrops).floor(), (j) => uuid.v1()));
    croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
        1 / numberCrops,
        1 / numberCrops,
        listCroppedImage,
        list_id);
    listCroppedImage = croppedImgConf.listCroppedImage;
    taquinBoard = exercise_6b.moveCropImage(numberCrops, img, gameStarted, listCroppedImage, coordFirstCard, false, list_id);
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
            height: 450,
            child: taquinBoard
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !gameStarted,
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    child: Icon(Icons.image, size: 50),
                    onPressed: (){
                     _pickImageFromGallery;
                    }
                    ),
                ),
              ),
              Visibility(
                visible: !gameStarted,
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    child: Icon(Icons.photo_camera, size: 50),
                    onPressed: (){
                      _takePicture;
                     /*  Navigator.push(
                              context,
                              MaterialPageRoute(builder: image.chooseImage),
                      ); */
                    }
                    ),
                ),
              )
            ],
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
                              list_id = List.generate(((oldTaquin.getNumberCrops-1)).floor(), (i) => List.generate(((oldTaquin.getNumberCrops-1)).floor(), (j) => uuid.v1()));
                              exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
                              1 / (oldTaquin.getNumberCrops-1),
                              1 / (oldTaquin.getNumberCrops-1),
                              listCroppedImage,
                              list_id
                              );
                              listCroppedImage = croppedImgConf.listCroppedImage;
                              taquinBoard = new exercise_6b.moveCropImage(oldTaquin.getNumberCrops-1, img, false, listCroppedImage, coordFirstCard, false, list_id);
                              listCroppedImage = taquinBoard.listCroppedImage;
                          }
                        }
                        );
                      },
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                             list_id = List.generate(((oldTaquin.getNumberCrops+1)).floor(), (i) => List.generate(((oldTaquin.getNumberCrops+1)).floor(), (j) => uuid.v1()));
                             exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
                              1 / (oldTaquin.getNumberCrops+1),
                              1 / (oldTaquin.getNumberCrops+1),
                              listCroppedImage,
                              list_id
                              );
                              listCroppedImage = croppedImgConf.listCroppedImage;
                             taquinBoard = new exercise_6b.moveCropImage(oldTaquin.getNumberCrops+1, img, false, listCroppedImage, coordFirstCard, false, list_id);
                             listCroppedImage = taquinBoard.listCroppedImage;
                          }
                        }
                        );
                      },
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      if(textButtonGame == "Start Game") {
                        textButtonGame = "Stop Game";
                        gameStarted = true;
                        mixTiles(taquinBoard.listCroppedImage, difficulty);
                        var oldTaquin = taquinBoard;
                        taquinBoard = exercise_6b.moveCropImage(oldTaquin.getNumberCrops, oldTaquin.img, gameStarted, listCroppedImageMixed, coordFirstCard, true, list_id);
                        buttonsColor = Colors.grey;
                      } else {
                        textButtonGame = "Start Game";
                        list_id = List.generate((4).floor(), (i) => List.generate((4).floor(), (j) => uuid.v1()));
                        gameStarted = false;
                        coordFirstCard = [0,0];
                        exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
                            1 / 4,
                            1 / 4,
                            listCroppedImage,
                            list_id);
                            listCroppedImage = croppedImgConf.listCroppedImage;
                        taquinBoard = exercise_6b.moveCropImage(numberCrops, img, gameStarted, croppedImgConf.listCroppedImage, coordFirstCard, true, list_id);
                        buttonsColor = Colors.blue;
                      }
                    });
                  }, 
                  child: Text(textButtonGame),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 30, right: 30),
              ),

              Container(
                child: DropdownButton(
                  value: dropdownvalue,
                  dropdownColor: Color.fromARGB(255, 236, 233, 233),
                  icon: const Icon(Icons.keyboard_arrow_down), 
                  items: difficulty_smileys.map((Emoji items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(parser.emojify(items.full)),
                    );
                  }).toList(),
                  onChanged: (Emoji? newValue) { 
                    setState(() {
                      if(!gameStarted) {
                        dropdownvalue = newValue!;
                        difficulty = list_difficulty[difficulty_smileys.indexOf(dropdownvalue)];
                      }
                    });
                  },
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 30, left: 30),
              ),
            ],
          )
        ],
    ),
    );
  }
}