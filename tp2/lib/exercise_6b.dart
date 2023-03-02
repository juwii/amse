import 'package:flutter/material.dart';
import 'exercise_4.dart';
import 'exercise_5b.dart' as exercise_5b;

class moveCropImage extends StatefulWidget {
  @override
  State<moveCropImage> createState() => _moveCropImage();
}

class _moveCropImage extends State<moveCropImage> {
  var _numberCrops = 4; // number of divisions of the cropped picture
  List<List<Tile>>? listCroppedImage;
  late exercise_5b.croppedImage croppedImgConf;
  var coordSelectedCard = List.empty();

  @override
  void initState() {
    super.initState();
    croppedImgConf = new exercise_5b.croppedImage(
        Image.asset("assets/images/avatar.jpg"),
        1 / _numberCrops,
        1 / _numberCrops,
        listCroppedImage);
  }

  bool isSwapPossible(int coord1, int coord2, int coord3, int coord4) {
    bool res = false;
    if ((((coord1 == coord3 - 1) || (coord1 == coord3 + 1)) &&
            (coord2 == coord4)) ||
        (((coord2 == coord4 - 1) || (coord2 == coord4 + 1)) &&
            (coord1 == coord3))) {
      res = true;
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Press two tiles to swap them'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(
                    top: 0, bottom: 20, left: 70, right: 70),
                itemCount: croppedImgConf.listCroppedImage!.length *
                    croppedImgConf.listCroppedImage!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: croppedImgConf.listCroppedImage!.length),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      splashColor: Colors.teal[400],
                      child: croppedImgConf.listCroppedImage?[
                              index % croppedImgConf.listCroppedImage!.length]
                              [index ~/ croppedImgConf.listCroppedImage!.length]
                          .croppedImageTile(),
                      onTap: () {
                        setState(() {
                          if (!coordSelectedCard.isEmpty) {
                            swapTiles(
                                croppedImgConf.listCroppedImage,
                                coordSelectedCard[0],
                                coordSelectedCard[1],
                                index % croppedImgConf.listCroppedImage!.length,
                                index ~/
                                    croppedImgConf.listCroppedImage!.length);
                            coordSelectedCard = List.empty();
                          } else {
                            coordSelectedCard = [
                              index % croppedImgConf.listCroppedImage!.length,
                              index ~/ croppedImgConf.listCroppedImage!.length
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
