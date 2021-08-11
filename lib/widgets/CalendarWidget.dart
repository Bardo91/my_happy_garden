import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:my_happy_garden/database/CalendarDatabase.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:my_happy_garden/database/Meeting.dart';

/// The hove page which hosts the calendar
class CalendarWidget extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Meeting> meetings = <Meeting>[];
  List<String> _actions = [ 'Regar', 'Abonar', 'Podar' ];
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
        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings( appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        onLongPress: (CalendarLongPressDetails details) => _showMyDialog(details),
      )
    );
  }

  void _showMyDialog(final CalendarLongPressDetails details) {
    if(details.appointments!.length != 0){

    }else{
        List<String> _selectedActions = [];

        showDialog(
          context: context,
          builder: (ctx) {
            return  MultiSelectDialog(
              items: _actions.map((e) => MultiSelectItem(e, e)).toList(),
              initialValue: _selectedActions,
              onConfirm: (values) {
                _selectedActions = values.map((e) => e.toString()).toList();
                setState(() {
                  _selectedActions.forEach((action) {
                    final DateTime startTime = DateTime(details.date!.year, details.date!.month, details.date!.day, 9, 0, 0);
                    final DateTime endTime = startTime.add(const Duration(minutes: 10));
                    final Meeting meeting = Meeting(action, startTime, endTime, const Color(0xFF0F8644), true);
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
