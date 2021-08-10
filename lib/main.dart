

import 'package:flutter/material.dart';
import 'package:my_happy_garden/widgets/MainWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Happy Garden',
      home: Scaffold(
        body: MainWidget(),
      ),
    );
  }
}
