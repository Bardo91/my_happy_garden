import 'package:flutter/material.dart';

class WikiWidget extends StatefulWidget {
  const WikiWidget({ Key? key }) : super(key: key);

  @override
  _WikiWidgetState createState() => _WikiWidgetState();
}

class _WikiWidgetState extends State<WikiWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: (MediaQuery.of(context).size.width~/200).toInt(),
                                                    childAspectRatio: 3 / 2,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20), 
                              itemCount: 10,
                              itemBuilder: (BuildContext ctx, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: Text("Object "+index.toString()),
                                                  decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius: BorderRadius.circular(15)),
                                                );
                                            }
                            )
    );
  }
}