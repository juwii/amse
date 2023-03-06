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

  moveCropImage(numberCrops, img, gameStarted, listCroppedImage, coordFirstCard, isMixing) {
    this.numberCrops = numberCrops;
    this.gameStarted = gameStarted;
    this.listCroppedImage = listCroppedImage;
    this.coordFirstCard = coordFirstCard;
    this.isMixing = isMixing;
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
  late Image img;
  List<List<Tile>>? listCroppedImage;
  late exercise_5b.croppedImage croppedImgConf;
  var coordSelectedCard = List.empty();
  var coordFirstCard = [0,0];
  bool _gameStarted = true;
  bool isMixing = false;  // variable to determine if the tiles were just mixed
  var numberMoves = 0;

  @override
  void initState() {
    super.initState();
    _gameStarted = widget.gameStarted;
    _numberCrops = widget.numberCrops;
    img = widget.img;
    coordFirstCard = widget.coordFirstCard;
    croppedImgConf = new exercise_5b.croppedImage(img,
        1 / _numberCrops,
        1 / _numberCrops,
        listCroppedImage);
    listCroppedImage = widget.listCroppedImage;
    isMixing = widget.isMixing;
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
          var temp = listCroppedImage![first_index][second_index];
          listCroppedImage[first_index][second_index] =
              listCroppedImage[third_index][fourth_index];
          listCroppedImage[third_index][fourth_index] = temp;
          coordFirstCard = [third_index, fourth_index];
          numberMoves++;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    
    _gameStarted = widget.gameStarted;
    isMixing = widget.isMixing;

    // code executed while the user did not swap tiles and reset
    if(!_gameStarted) {
      coordSelectedCard = List.empty();
      numberMoves = 0;
      _numberCrops = widget.numberCrops;
      img = widget.img;
      croppedImgConf = new exercise_5b.croppedImage(img,
        1 / _numberCrops,
        1 / _numberCrops,
        listCroppedImage);
      listCroppedImage = widget.listCroppedImage;
    }
    // code executed before the first move
    if(isMixing) {
      coordFirstCard = widget.coordFirstCard;
    }
    
    List<List<Tile>>? reslistCroppedImage;
    exercise_5b.croppedImage res = new exercise_5b.croppedImage(img,
        1 / _numberCrops,
        1 / _numberCrops,
        reslistCroppedImage);
    if(listEquals(res.listCroppedImage, listCroppedImage)) {
      print("gagné");
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
                    top: 0, bottom: 20, left: 70, right: 70),
                itemCount: listCroppedImage!.length *
                    listCroppedImage!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: listCroppedImage!.length),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
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
                          if (!coordSelectedCard.isEmpty && _gameStarted) {
                            swapTiles(
                                listCroppedImage,
                                coordSelectedCard[0],
                                coordSelectedCard[1],
                                index % listCroppedImage!.length,
                                index ~/
                                    listCroppedImage!.length);
                            coordSelectedCard = List.empty();
                          } else if(coordSelectedCard.isEmpty && _gameStarted){
                            coordSelectedCard = [
                              index % listCroppedImage!.length,
                              index ~/ listCroppedImage!.length
                            ];
                          }
                        });
                      },
                    ),
                  );
                }),
          ],
        ));
  }
}

class exMoveTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<List<Tile>>? listCroppedImage;
    exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"),
        1 / 4,
        1 / 4,
        listCroppedImage);
    return Scaffold(
    appBar: AppBar(
            title: Text('Press two tiles to swap them'),
          ),
    body: 
      Column(
        children: [
          Container(
            height: 500,
            child: moveCropImage(4, Image.asset("assets/images/avatar.jpg"), true, croppedImgConf.listCroppedImage, [0,0], false)
          ),
        ],
      ),
    );
  }
}

