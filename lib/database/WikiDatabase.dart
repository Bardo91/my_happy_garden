import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class WikiEntry {
  final String title;
  final String image;
  final String content;

  WikiEntry(this.title, this.image, this.content );
}

class WikiDatabase{ 
  final int DATABASE_VERSION = 1;
  final String DATABASE_NAME = "wiki.json";
  final String DATABASE_URL = "http://pabramsor.com/wp-content/uploads/2021/08/wiki.json";
  
  static final WikiDatabase _singleton = WikiDatabase._internal();
  WikiDatabase._internal();

  factory WikiDatabase() {
    return _singleton;
  }

  bool _isOpen = false;
  List<dynamic> _database = [];

  bool get isOpen{
    return _isOpen;
  }

  Future<bool> open() async{
    if(_isOpen)
      return true;
    
    String dbPath = DATABASE_NAME;// join(applicationDirectory.path, DATABASE_NAME);

    final response = await http.get(Uri.parse(DATABASE_URL));

    // thow an error if there was error getting the file
    // so it prevents from wrting the wrong content into the db file
    if (response.statusCode != 200) throw "Error getting db file";
    _database = json.decode(response.body);

    _isOpen = true;

    return true;
  }


  Future<List<WikiEntry>> getEntries() async{
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    List<WikiEntry> entries = List.generate(_database.length, (i) {
      return WikiEntry( _database[i]['title'], _database[i]['image'], _database[i]['description']);
    });

    return entries;
  }


}