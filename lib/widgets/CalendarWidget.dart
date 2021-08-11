import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:my_happy_garden/database/CalendarDatabase.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:my_happy_garden/database/Meeting.dart';


class AvailableActions{
  AvailableActions({required this.name, required this.color});
  String name ="";
  Color color = Color(0x70707070);
}

/// The hove page which hosts the calendar
class CalendarWidget extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Meeting> meetings = <Meeting>[];
  List<AvailableActions> _actions = [ AvailableActions(name: 'Regar', color: Color(0xFF3AB0FB)), 
                                      AvailableActions(name: 'Abonar', color: Color(0xFF71FF8C)), 
                                      AvailableActions(name: 'Podar', color: Color(0xFFFA7D6D)) ];
  CalendarDatabase _db = new CalendarDatabase();

  _CalendarWidgetState(){
    _db.open().then((value) {
      setState(() {
        meetings = _db.getEvents();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(meetings),
        monthViewSettings: const MonthViewSettings( appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        onLongPress: (CalendarLongPressDetails details) => _showMyDialog(details),
        appointmentTextStyle: TextStyle(  fontSize: 12, 
                                          color: Colors.black87),
      )
    );
  }

  void _showMyDialog(final CalendarLongPressDetails details) {
    if(details.appointments!.length != 0){

    }else{
        List<AvailableActions> _selectedActions = [];

        showDialog(
          context: context,
          builder: (ctx) {
            return  MultiSelectDialog(
              items: _actions.map((e) => MultiSelectItem(e, e.name)).toList(),
              initialValue: _selectedActions,
              onConfirm: (values) {
                _selectedActions = values.cast();
                setState(() {
                  _selectedActions.forEach((action) {
                    final DateTime startTime = DateTime(details.date!.year, details.date!.month, details.date!.day, 9, 0, 0);
                    final DateTime endTime = startTime.add(const Duration(minutes: 10));
                    final Meeting meeting = Meeting(action.name, startTime, endTime, action.color, true);
                    meetings.add(meeting);
                    _db.insertEvent(meeting);
                  });
                });
              },
            );
          },
        );      
    }
  }
}
