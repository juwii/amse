import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'exercise_4.dart';
import 'exercise_5b.dart' as exercise_5b;

class moveCropImage extends StatefulWidget {
  var numberCrops = 4;
  bool gameStarted = true;
  Image img = Image.asset("assets/images/avatar.jpg");
  List<List<Tile>>? listCroppedImage;
  var coordFirstCard = [0, 0];
  bool isMixing = false;
  var list_id;
  moveCropImage(numberCrops, img, gameStarted, listCroppedImage, coordFirstCard, isMixing, list_id) {
    this.numberCrops = numberCrops;
    this.gameStarted = gameStarted;
    this.listCroppedImage = listCroppedImage;
    this.coordFirstCard = coordFirstCard;
    this.isMixing = isMixing;
    this.list_id = list_id;
  }

  @override
  State<moveCropImage> createState() => _moveCropImage();
  
  int get getNumberCrops {
    return numberCrops;
  }

  void modifyNumberCrops(int _numberCrops) {
    numberCrops = _numberCrops;
  }
}

class _moveCropImage extends State<moveCropImage> {

  var _numberCrops; // number of divisions of the cropped picture
  late Image img; // picture used for the taquin board
  List<List<Tile>>? listCroppedImage;
  late exercise_5b.croppedImage croppedImgConf; // 
  var coordFirstCard = [0,0]; // coordinates of the unique movable tile
  bool _gameStarted = true; // state of the game
  bool isMixing = false;  // variable to determine if the tiles were just mixed
  var numberMoves = 0;  // number incremented each moves when the game is on
  var coordLastMove = List.empty(); // list containing 4 elements: coordinates of the two swapped tiles
  var list_id;

  @override
  void initState() {
    super.initState();
    _gameStarted = widget.gameStarted;
    _numberCrops = widget.numberCrops;
    img = widget.img;
    coordFirstCard = widget.coordFirstCard;
    list_id = widget.list_id;
    croppedImgConf = new exercise_5b.croppedImage(img,
        1 / _numberCrops,
        1 / _numberCrops,
        listCroppedImage,
        list_id);
    listCroppedImage = widget.listCroppedImage;
    isMixing = widget.isMixing;
  }

  bool isWon() {
    var res = true;
    for(var i = 0; i < listCroppedImage!.length; i++) {
      for(var j = 0; j < listCroppedImage!.length; j++) {
        if(listCroppedImage![i][j].id != list_id[i][j]) {
          res = false;
        }
      }
    }
    return res;
  }

  bool isSwapPossible(int coord1, int coord2, int coord3, int coord4) {
    bool res = false;
    if(coord1 == coordFirstCard[0] && coord2 == coordFirstCard[1]){
    if ((((coord1 == coord3 - 1) || (coord1 == coord3 + 1)) &&
            (coord2 == coord4)) ||
        (((coord2 == coord4 - 1) || (coord2 == coord4 + 1)) &&
            (coord1 == coord3))) {
      res = true;
      widget.isMixing = false;  // the coordinates of the selected tile can be updated
    } 
    }
    return res;
  }

  swapTiles(List<List<Tile>>? listCroppedImage, int first_index,
      int second_index, int third_index, fourth_index) {
      setState(() {
        if (isSwapPossible(
            first_index, second_index, third_index, fourth_index)) {
          coordLastMove = [first_index, second_index, third_index, fourth_index];
          var temp = listCroppedImage![first_index][second_index];
          listCroppedImage[first_index][second_index] =
              listCroppedImage[third_index][fourth_index];
          listCroppedImage[third_index][fourth_index] = temp;
          coordFirstCard = [third_index, fourth_index];
          numberMoves++;
        }
      });
  }

    showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Congrats!"),
      icon: Icon(Icons.celebration),
      content: Text("You finished the taquin. You can stop the game and begin a new one!"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    _gameStarted = widget.gameStarted;
    isMixing = widget.isMixing;
    list_id = widget.list_id;

    // code executed while the user did not swap tiles and reset
    if(!_gameStarted) {
      numberMoves = 0;
      _numberCrops = widget.numberCrops;
      img = widget.img;
      croppedImgConf = new exercise_5b.croppedImage(img,
        1 / _numberCrops,
        1 / _numberCrops,
        listCroppedImage,
        list_id);
      listCroppedImage = widget.listCroppedImage;
      coordLastMove = List.empty();
    }
    // code executed before the first move
    if(isMixing) {
      coordFirstCard = widget.coordFirstCard;
    }

    return Scaffold(
      
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Number of moves: $numberMoves"),
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(
                    top: 0, bottom: 10, left: 20, right: 20),
                itemCount: listCroppedImage!.length *
                    listCroppedImage!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: listCroppedImage!.length),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      splashColor: Colors.teal[400],
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: (index % listCroppedImage!.length == coordFirstCard[0] && index ~/ listCroppedImage!.length == coordFirstCard[1]) ?  Colors.teal[400] : Colors.white,
                        child: listCroppedImage?[
                                index % listCroppedImage!.length]
                                [index ~/ listCroppedImage!.length]
                            .croppedImageTile(),
                      ),
                      onTap: () {
                        setState(() {
                          if (_gameStarted) {
                            swapTiles(
                                listCroppedImage,
                                coordFirstCard[0],
                                coordFirstCard[1],
                                index % listCroppedImage!.length,
                                index ~/
                                    listCroppedImage!.length);
                                if(isWon() && _gameStarted) {
                                  showAlertDialog(context);
                                }
                                
                          }
                        
                        });
                      },
                    ),
                  );
                }),

                Container(
                height: 50,
                    child: Visibility(
                      visible: !coordLastMove.isEmpty,
                      child: FloatingActionButton(
                        heroTag: "cancel",
                        backgroundColor: Colors.red,
                        child: Icon(Icons.undo),
                        onPressed: () {
                          setState(() {
                            if(_gameStarted && !coordLastMove.isEmpty){
                              swapTiles(listCroppedImage, coordLastMove[2], coordLastMove[3], coordLastMove[0], coordLastMove[1]);
                              coordLastMove = List.empty();
                              numberMoves = numberMoves - 2;  // deletes the incrementation in swap and -1 to cancel the move
                            }
                          }
                        );
                      },
                    ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  ),
          ],
        ));
  }
}

class exMoveTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list_id = List.generate((1/0.25).floor(), (i) => List.generate((1/0.25).floor(), (j) => DateTime.now().millisecondsSinceEpoch));
    List<List<Tile>>? listCroppedImage;
    exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
        1 / 4,
        1 / 4,
        listCroppedImage,
        list_id);
    return Scaffold(
    appBar: AppBar(
            title: Text('Press two tiles to swap them'),
          ),
    body: 
      Column(
        children: [
          Container(
            height: 500,
            child: moveCropImage(4, Image.asset("assets/images/avatar.jpg"), true, croppedImgConf.listCroppedImage, [0,0], false, list_id)
          ),
        ],
      ),
    );
  }
}

