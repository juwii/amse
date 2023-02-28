import 'package:flutter/material.dart';
import 'exercise_4.dart';
import 'exercise_5b.dart' as exercise_5b;

class configureCropImage extends StatefulWidget {
  @override
  State<configureCropImage> createState() => _configureCropImage();
}

class _configureCropImage extends State<configureCropImage> {
  
  var _numberCrops = 4;  // number of divisions of the cropped picture
  
  @override
  Widget build(BuildContext context) {
    List<List<Tile>>? listCroppedImage;
    exercise_5b.croppedImage croppedImgConf = new exercise_5b.croppedImage(Image.asset("assets/images/avatar.jpg"), 1/_numberCrops, 1/_numberCrops, listCroppedImage);
    return Scaffold(
        appBar: AppBar(
          title: Text('Configure the number of crops'),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(top: 0, bottom: 20, left: 70, right: 70),
            itemCount: croppedImgConf.listCroppedImage!.length*croppedImgConf.listCroppedImage!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: croppedImgConf.listCroppedImage!.length),
            itemBuilder: (BuildContext context, int index) { 
              return Container(
                padding: const EdgeInsets.all(3),
                color: Colors.teal[400],
                child: croppedImgConf.listCroppedImage?[index % croppedImgConf.listCroppedImage!.length][index ~/ croppedImgConf.listCroppedImage!.length].croppedImageTile(),
              );
            }
          ),
          Container(
            child: Text(
              _numberCrops.toString(), 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              alignment: Alignment.bottomCenter
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FloatingActionButton(
                  heroTag: "minus",
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if(_numberCrops <= 10 && _numberCrops >= 3) {
                          _numberCrops--;
                      }
                    }
                    );
                  },
                ),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(30),
              ),
              Container(
                child: FloatingActionButton(
                  heroTag: "more",
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                     if(_numberCrops <= 9 && _numberCrops >= 2) {
                          _numberCrops++;
                      }
                    }
                    );
                  },
                ),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(30),
              ),
            ]
          ),
        ],
      )
    );
  }
}