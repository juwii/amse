import 'package:flutter/material.dart';
import 'exercise_4.dart';

class croppedImage {
  Image img;
  var widthFactor;
  var heightFactor;
  List<List<Tile>>? listCroppedImage;
  var id = [[]];

  void initializeListCroppedImage() {
      
      listCroppedImage = List.generate((1/this.widthFactor).floor(),
    (i) => List.generate((1/this.heightFactor).floor(), (j) => new Tile(img: img, x: i*2/(1/widthFactor - 1) - 1, y: j*2/(1/heightFactor - 1) - 1, widthFactor: this.widthFactor, heightFactor: this.heightFactor, id: this.id[i][j]), growable: true),
    growable: true);
  }

  croppedImage(this.img, this.widthFactor, this.heightFactor, this.listCroppedImage, this.id) {
      this.initializeListCroppedImage();
  }
}

List<List<Tile>>? listCroppedImage;
var list_id = List.generate((1/0.25).floor(), (i) => List.generate((1/0.25).floor(), (j) => DateTime.now().millisecondsSinceEpoch));
croppedImage croppedImg = new croppedImage(Image.asset("assets/images/avatar.jpg"), 0.25, 0.25, listCroppedImage, list_id);

class DisplayGridCroppedImageWidget extends StatelessWidget {
 
 Widget createTileWidgetFrom(Tile ?tile) {
    return InkWell(
      child: tile?.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Example of a cropped picture'),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(50),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 4,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[0][0]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[1][0]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[2][0]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[3][0]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[0][1]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[1][1]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[2][1]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[3][1]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[0][2]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[1][2]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[2][2]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[3][2]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[0][3]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[1][3]),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[2][3]),
            ), 
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.teal[400],
              child: this.createTileWidgetFrom(croppedImg.listCroppedImage?[3][3]),
            ),
          ],
        ),);
  }
}