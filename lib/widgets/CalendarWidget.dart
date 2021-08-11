import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
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
                    meetings.add(Meeting(action, startTime, endTime, const Color(0xFF0F8644), true));
                  });
                });
              },
            );
          },
        );      
    }
    
  }

  List<Meeting> _getDataSource() {
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}