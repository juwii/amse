import 'package:flutter/material.dart';

class Tile {
  Image img;
  var widthFactor;
  var heightFactor;
  var x;  // coordinate of the crop in x axis
  var y;  // coordinate of the crop in y axis
  var id;

  Tile({required this.img, this.x, this.y, required this.widthFactor, required this.heightFactor, this.id});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        //clipper: 
        child: Container(
          child: Align(
            alignment: Alignment(x,y),
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: img,
          ),
        ),
      ),
    );
  }
}

Tile tile = new Tile(
    img: Image.asset("assets/images/avatar.jpg"), x: 1.0, y: 1.0, widthFactor: 0.25, heightFactor: 0.25);

class DisplayTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display a Tile as a Cropped Image'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: this.createTileWidgetFrom(tile))),
        Container(
            height: 200,
            child: Image.asset("assets/images/avatar.jpg"))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}