import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:my_happy_garden/database/UserData.dart';
import 'package:my_happy_garden/widgets/AlbumWidget.dart';
import 'package:my_happy_garden/widgets/CalendarWidget.dart';
import 'package:my_happy_garden/widgets/WikiWidget.dart';
import 'package:my_happy_garden/widgets/GardenWidget.dart';

enum MenuOptions { Calendar, Wiki, Garden, Album }

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<CollapsibleItem> _items = [];
  String _userName = "Unknown";

  CalendarWidget _calendar = CalendarWidget();
  WikiWidget _wiki = WikiWidget();
  AlbumWidget _album = AlbumWidget();
  GardenWidget _garden = GardenWidget();

  MenuOptions _currentMenu = MenuOptions.Calendar;

  UserData _userData = UserData();

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _userData.init().then((value) => {
          if (_userData.userImage != "")
            {
              setState(() {
                _userName = _userData.userName;
              })
            }
        });
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
        text: 'My garden',
        icon: Icons.emoji_nature,
        onPressed: () => setState(() => _currentMenu = MenuOptions.Garden),
      ),
      CollapsibleItem(
        text: 'Album',
        icon: Icons.photo_library,
        onPressed: () => setState(() => _currentMenu = MenuOptions.Album),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        items: _items,
        avatarImg: AssetImage(_userData.userImage),
        title: _userName,
        onTitleTap: () {
          userDialog();
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
      case MenuOptions.Garden:
        widget = _garden;
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
      child: Center(child: widget),
    );
  }

  void userDialog() {
    final double ctPadding = 20;
    final double ctAvatarRadius = 45;
    final double ctPaddingPercSides = 0.2;

    showDialog(
        context: context,
        builder: (ctx) {
          final TextEditingController _textFieldController =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState){
            return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: ctPadding,
                    top: ctAvatarRadius + ctPadding,
                    right: ctPadding,
                    bottom: ctPadding),
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width *
                        ctPaddingPercSides,
                    top: ctAvatarRadius,
                    right: MediaQuery.of(context).size.width *
                        ctPaddingPercSides,
                    bottom: ctPadding),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ctPadding),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 10),
                          blurRadius: 10),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Change User name'),
                                content: TextField(
                                  controller: _textFieldController,
                                  decoration:
                                      InputDecoration(hintText: "User name"),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Change'),
                                    onPressed: () {
                                      if(_textFieldController.text.length > 4){
                                        _userName = _textFieldController.text;
                                        _userData.userName = _userName;
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              );
                            }).then((value) {setState(() { });});
                      },
                      child: Text(
                        _userName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "You are my favourite user",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: ctPadding,
                  right: ctPadding,
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: ctAvatarRadius,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ctAvatarRadius)),
                          child: Image(image: AssetImage(_userData.userImage))),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Country List'),
                              content: Container(
                                  height: 400,
                                  width: 400,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(child: Container(
                                          width: 150,
                                          child: Center(
                                              child: CircleAvatar(child: Image.asset('assets/images/users/user_image_'+index.toString()+'.png'),
                                              backgroundColor: Colors.grey[200],)
                                              ),
                                        ),
                                        onTap: (){
                                            _userData.userImage = 'assets/images/users/user_image_'+index.toString()+'.png';
                                            Navigator.of(context).pop();
                                        },);
                                      })),
                            );
                          }).then((value) {setState(() { });});
                    },
                  )),
            ],
          );
          });
        }).then((value) {setState(() { });});
  }
}
