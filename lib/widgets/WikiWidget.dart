import 'package:flutter/material.dart';
import 'package:my_happy_garden/database/WikiDatabase.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WikiWidget extends StatefulWidget {
  WikiWidget({Key? key}) : super(key: key);

  @override
  _WikiWidgetState createState() => _WikiWidgetState();
}

class _WikiWidgetState extends State<WikiWidget> {
  WikiDatabase _database = new WikiDatabase();
  List<WikiEntry> _entries = [];
  _WikiWidgetState() {
    _database.open().then((value) {
      setState(() {
        _database.getEntries().then((value) => _entries = value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3),
      itemCount: _entries.length,
      itemBuilder: (BuildContext ctx, index) {
        return GestureDetector(
            child: Container(
              child: Card(
                child: Column(
                  children: [
                    AspectRatio(
                        aspectRatio: 2,
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: _entries[index].image,
                        )),
                    Text(_entries[index].title + "\n",textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
            onTap: () => openDialog(
                CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: _entries[index].image,
                ),
                _entries[index].title,
                _entries[index].content));
      },
    ));
  }

  void openDialog(final CachedNetworkImage image, final String title,
      final String description) {
    final double ctPadding = 20;
    final double ctAvatarRadius = 45;
    showDialog(
        context: context,
        builder: (ctx) {
          return Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      left: ctPadding,
                      top: ctAvatarRadius + ctPadding,
                      right: ctPadding,
                      bottom: ctPadding),
                  margin: EdgeInsets.only(top: ctAvatarRadius),
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          description,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
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
                  )),
              Positioned(
                left: ctPadding,
                right: ctPadding,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: ctAvatarRadius,
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(ctAvatarRadius)),
                      child: image),
                ),
              ),
            ],
          );
        });
  }
}
