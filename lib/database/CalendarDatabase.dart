import 'package:my_happy_garden/database/Meeting.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalendarEvent {
  CalendarEvent({required this.name, required this.from, required this.to});
  String name = "";
  DateTime from = new DateTime(2021);
  DateTime to = new DateTime(2021);

  @override
  String toString() => name+from.toString(); // Just for print()
}

class CalendarEventAdapter extends TypeAdapter<CalendarEvent> {
  @override
  final typeId = 0;

  @override
  CalendarEvent read(BinaryReader reader) {
    return CalendarEvent(name:reader.readString(), 
                        from:DateTime.parse(reader.readString()),
                        to:DateTime.parse(reader.readString()));
  }

  @override
  void write(BinaryWriter writer, CalendarEvent event) {
    writer.writeString(event.name);
    writer.writeString(event.from.toString());
    writer.writeString(event.to.toString());
  }
}

class CalendarDatabase{

  final int DATABASE_VERSION = 1;
  final String DATABASE_NAME = "calendar.db";

  bool _isOpen = false;
  Box<CalendarEvent>? _database;

  bool isOpen(){
    return _isOpen;
  }

  Future<bool> open() async{
    await Hive.initFlutter();
    Hive.registerAdapter(CalendarEventAdapter());

    _database = await Hive.openBox(DATABASE_NAME);
    if(!_database!.isOpen){
      _isOpen = false;
      return false;
    }


    return _isOpen;
  }

  List<Meeting> getEvents(){
    List<Meeting> events = [];
    var all = _database?.toMap().forEach((key, value) {
      events.add(
        Meeting(  value.name, 
                  value.from,
                  value.to,
                  Color(0xFF0F8644), 
                  true)
      ); 
    });
    return events;
  }

  void insertEvent(Meeting event) {
    var hiveEvent =  CalendarEvent( name: event.eventName, 
                                    from: event.from, 
                                    to: event.to);
    _database?.add(hiveEvent);
  }

}