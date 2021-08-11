import 'package:my_happy_garden/database/Meeting.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalendarEvent {
  CalendarEvent({required this.name, required this.from, required this.to, required this.color});
  String name;
  DateTime from;
  DateTime to;
  Color color;

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
                        to:DateTime.parse(reader.readString()),
                        color: Color(reader.readInt32()));
  }

  @override
  void write(BinaryWriter writer, CalendarEvent event) {
    writer.writeString(event.name);
    writer.writeString(event.from.toString());
    writer.writeString(event.to.toString());
    writer.writeInt32(event.color.value);
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
                  value.color, 
                  true)
      ); 
    });
    return events;
  }

  void insertEvent(Meeting event) {
    var hiveEvent =  CalendarEvent( name: event.eventName, 
                                    from: event.from, 
                                    to: event.to,
                                    color: event.background);
    _database?.add(hiveEvent);
  }

}