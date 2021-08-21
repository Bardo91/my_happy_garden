import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_happy_garden/database/GardenDatabase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class GardenWidget extends StatefulWidget {
  const GardenWidget({ Key? key }) : super(key: key);

  @override
  _GardenWidgetState createState() => _GardenWidgetState();
}

class _GardenWidgetState extends State<GardenWidget> {
  final ImagePicker _picker = ImagePicker();

  GardenDatabase _database = new GardenDatabase();
  List<PlantData> plants = [];
  _GardenWidgetState() {
    _database.open().then((value) {
      setState(() {
        plants = _database.getPlants();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
          ),
          itemCount: plants.length+1,
          itemBuilder: (BuildContext context, int index) {
            if(index == plants.length){
              return CircleAvatar(
                child: FlatButton(
                  child: Icon(Icons.add),
                  onPressed: (){
                    final PlantData plant = PlantData("assets/images/garden/default_plant_image.png", "New friend", 0);
                    _database.insertPlant(plant);
                    plants.add(plant);
                    setState(() { });
                  },
                ),
              );
            }else{
              return createPlant(index);
            }
          }
      )
    );
  }

  Container createPlant(final index){
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: plants[index].imagePath.contains("assets")?
                                    Image.asset(plants[index].imagePath,  height: 175):
                                    Image.file( File(plants[index].imagePath), height: 175,),
            onTap: (){
              getImageAndSave(index);
            },
          ),
          Center(child: Text('Plant $index')),
          Center(child: Text('Type')),
          Center(child: Text('Humidity')),
        ],
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(0, 1),
                blurRadius: 3),
          ]),
    );
  }

  void getImageAndSave(index) async{
      var image = await _picker.pickImage(source: ImageSource.camera);
      // getting a directory path for saving
      var dir = await getApplicationDocumentsDirectory();
      String path = dir.path + '/' + basename(image!.path);
      // copy the file to a new path
      image.saveTo(path);
      plants[index].imagePath = path;

      setState(() {

      });
  }

}