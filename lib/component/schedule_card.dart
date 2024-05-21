import 'package:flutter/material.dart';
import 'package:calendar/const/color.dart';

class ScheduleCard extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String content;
  final Color color;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 1 -> 01
                  /// 10 -> 10 2자리 숫자가 아닐 때 왼쪽으로 0을 채운다.
                  Text('${startTime.hour.toString().padLeft(2, '0')}:00', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontSize: 16.0,
                  ),
                  ),
                  Text('${endTime.hour.toString().padLeft(2, '0')}:00', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontSize: 16.0
                  ),
                  ),
                ],
              ),
              SizedBox(width: 16.0),
              Expanded(
                  child: Text(content)
              ),
              Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                width: 16.0,
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
