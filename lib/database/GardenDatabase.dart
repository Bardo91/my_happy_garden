import 'package:my_happy_garden/database/Meeting.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class PlantData{
  PlantData(this.imagePath, this.name, this.humidity);
  String imagePath;
  String name;
  int humidity;

  @override
  String toString() => name; // Just for print()
}

class PlantDataAdapter extends TypeAdapter<PlantData> {
  @override
  final typeId = 1;

  @override
  PlantData read(BinaryReader reader) {
    return PlantData( reader.readString(),
                      reader.readString(),
                      reader.readInt());
  }

  @override
  void write(BinaryWriter writer, PlantData plant) {
    writer.writeString(plant.imagePath);
    writer.writeString(plant.name);
    writer.writeInt(plant.humidity);
  }
}

class GardenDatabase{
  /// Static interface
  static const String DATABASE_NAME = "garden.db";

  static final GardenDatabase _singleton = GardenDatabase._internal();
  GardenDatabase._internal();

  factory GardenDatabase() {
    return _singleton;
  }

  /// Object interface
  bool _isOpen = false;
  Box<PlantData>? _database;

  bool isOpen(){
    return _isOpen;
  }

  Future<bool> open() async{
    if(!_isOpen){
      await Hive.initFlutter();
      Hive.registerAdapter(PlantDataAdapter());

      _database = await Hive.openBox(DATABASE_NAME);
      if(!_database!.isOpen){
        _isOpen = false;
        return false;
      }
      _isOpen = true;
    }
    return _isOpen;
  }

  List<PlantData> getPlants(){
    List<PlantData> plants = [];
    var all = _database?.toMap().forEach((key, value) {
      plants.add(value);
    });
    return plants;
  }

  void insertPlant(PlantData data) {
    _database?.add(data);
  }


}