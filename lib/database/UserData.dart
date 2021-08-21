
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserData{
  //Static interface
  static final UserData _userData = new UserData._internal();
  static const String DATABASE_NAME = "user.db";

  factory UserData(){
    return _userData;
  }

  UserData._internal(){
    Hive.initFlutter();
  }

  // Public Object interface
  bool isOpen(){
    return _isOpen;
  }

  Future<bool> init() async{
    if(!_isOpen){
      await Hive.initFlutter();

      _database = await Hive.openBox(DATABASE_NAME);
      if(!_database!.isOpen){
        _isOpen = false;
        return false;
      }
      _isOpen = true;
    }
    return _isOpen;
  }

  set userImage(String image){
    _database?.put('image', image);

  }

  set userName(String name){
    _database?.put('name', name);
  }

  String get userImage{
    return _database?.get('image')==null?"assets/images/users/unknown_user.png":_database?.get('image');
  }

  String get userName{
    return _database?.get('name')==null?"Unknown":_database?.get('name');
  }

  // Private members
  bool _isOpen = false;
  Box? _database;

  
}