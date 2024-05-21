import 'package:calendar/component/t_calendar.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:calendar/const/color.dart';
import 'package:flutter/material.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/schedule_bottom_sheet.dart';

import '../model/schedule.dart';

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

  /// {
  /// 2024-05-20:[Schedule, Schedule],
  /// 2023-05-21:[Schedule, Schedule],
  /// }
  Map<DateTime, List<Schedule>> schedules = {
    DateTime.utc(2024, 5, 8): [
      Schedule(
        id: 1,
        startTime: 11,
        endTime: 11,
        content: '플러터 공부하기',
        date: DateTime.utc(2024, 5, 8),
        color: categoryColors[0],
        createdAt: DateTime.now().toUtc(),
      ),
      Schedule(
        id: 2,
        startTime: 14,
        endTime: 16,
        content: '플러터 공부하기 - 1',
        date: DateTime.utc(2024, 5, 8),
        color: categoryColors[3],
        createdAt: DateTime.now().toUtc(),
      ),
      Schedule(
        id: 3,
        startTime: 18,
        endTime: 22,
        content: '플러터 공부하기 - 2',
        date: DateTime.utc(2024, 5, 8),
        color: categoryColors[1],
        createdAt: DateTime.now().toUtc(),
      ),
    ]
  };

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
              child: ListView.separated(
                itemCount: schedules.containsKey(selectedDay)
                    ? schedules[selectedDay]!.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  final selectedSchedules = schedules[selectedDay]!;
                  final schedulModel = selectedSchedules[index];

                  return ScheduleCard(
                    startTime: schedulModel.startTime,
                    endTime: schedulModel.endTime,
                    content: schedulModel.content,
                    color:
                        Color(int.parse('FF${schedulModel.color}', radix: 16)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8.0);
                },
              ),
            ),
          ),
        ]),
      ),
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
