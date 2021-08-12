
import 'package:flutter/material.dart';

class UserData{
  //Static interface
  static final UserData _userData = new UserData._internal();

  factory UserData(){
    return _userData;
  }

  UserData._internal();

  // Public Object interface

  // Private members
  Image? _userImage;

  
}