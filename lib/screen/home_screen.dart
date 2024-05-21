import 'package:calendar/component/t_calendar.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:calendar/const/color.dart';
import 'package:flutter/material.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/schedule_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet();
            },
          );
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: Column(children: [
        TCalendar(
          focusedDay: DateTime(2024, 5, 1),
          onDaySelected: onDaySelected,
          selectedDayPredicate: selectedDayPredicate,
        ),
        TodayBanner(selectedDay: selectedDay, taskCount: 0),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: ListView(children: [
            ScheduleCard(
                startTime: DateTime(2024, 05, 09, 11),
                endTime: DateTime(2024, 05, 15, 12),
                content: '플러터 공부하기',
                color: Colors.blue)
          ]),
        )),
      ])),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }
    return date.isAtSameMomentAs(selectedDay!);
  }
}
