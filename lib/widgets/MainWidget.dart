import 'dart:math' as math show pi;

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:my_happy_garden/widgets/AlbumWidget.dart';
import 'package:my_happy_garden/widgets/CalendarWidget.dart';
import 'package:my_happy_garden/widgets/WikiWidget.dart';

enum MenuOptions {Calendar, Wiki, Album}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<CollapsibleItem> _items = [];
  String _userName = "Unknown";
  AssetImage _avatarImg = AssetImage('assets/unknown_user.png');

  CalendarWidget _calendar = CalendarWidget();
  WikiWidget _wiki = WikiWidget();
  AlbumWidget _album = AlbumWidget();

  MenuOptions _currentMenu = MenuOptions.Calendar;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Calendar',
        icon: Icons.calendar_view_month,
        onPressed: () => setState(() => _currentMenu = MenuOptions.Calendar),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Wiki',
        icon: Icons.info,
        onPressed: () => setState(() => _currentMenu = MenuOptions.Wiki),
      ),
      CollapsibleItem(
        text: 'Album',
        icon: Icons.photo_library,
        onPressed: () => setState(() => _currentMenu = MenuOptions.Album ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        items: _items,
        avatarImg: _avatarImg,
        title: _userName,
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    Widget widget = _calendar;

    switch (_currentMenu) {
      case MenuOptions.Calendar:
        widget = _calendar;    
        break;
      case MenuOptions.Wiki:
        widget = _wiki;    
        break;
      case MenuOptions.Album:
        widget = _album;    
        break;
      default:
        widget = _calendar;
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(child: widget ),
    );
  }

}