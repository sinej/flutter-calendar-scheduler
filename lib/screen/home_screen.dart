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
  // Map<DateTime, List<ScheduleTable>> schedules = {
  //   DateTime.utc(2024, 5, 8): [
  //     ScheduleTable(
  //       id: 1,
  //       startTime: 11,
  //       endTime: 11,
  //       content: '플러터 공부하기',
  //       date: DateTime.utc(2024, 5, 8),
  //       color: categoryColors[0],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //     ScheduleTable(
  //       id: 2,
  //       startTime: 14,
  //       endTime: 16,
  //       content: '플러터 공부하기 - 1',
  //       date: DateTime.utc(2024, 5, 8),
  //       color: categoryColors[3],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //     ScheduleTable(
  //       id: 3,
  //       startTime: 18,
  //       endTime: 22,
  //       content: '플러터 공부하기 - 2',
  //       date: DateTime.utc(2024, 5, 8),
  //       color: categoryColors[1],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //   ]
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable>(
              context: context,
              builder: (_) {
                return ScheduleBottomSheet(
                  selectedDay: selectedDay,
                );
              });

          if (schedule == null) return;

          // final dateExists = schedules.containsKey(schedule.date);
          // final List<ScheduleTable> existingSchedules =
          //     dateExists ? schedules[schedule.date]! : [];

          // existingSchedules!.add(schedule);

          // setState(() {
          //   schedules = {
          //     ...schedules,
          //     schedule.date: existingSchedules,
          //   };
          // });

          // setState(() {
          //   schedules = {
          //     ...schedules,
          //     schedule.date: [
          //       if(schedules.containsKey(schedule.date))
          //         ...schedules[schedule.date]!, schedule,
          //     ]
          //   };
          // });
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
                itemCount: 0,
                itemBuilder: (BuildContext context, int index) {
                  // final selectedSchedules = schedules[selectedDay]!;
                  // final schedulModel = selectedSchedules[index];

                  return ScheduleCard(
                    startTime: 12, // schedulModel.startTime,
                    endTime: 12, // schedulModel.endTime,
                    content: 'test', // schedulModel.content,
                    color: Color(int.parse('FF000000', radix: 16)),
                        // Color(int.parse('FF${schedulModel.color}', radix: 16)),
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
