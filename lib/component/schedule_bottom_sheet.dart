import 'package:calendar/model/schedule.dart';
import 'package:flutter/material.dart';

import '../const/color.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  const ScheduleBottomSheet({
    required this.selectedDay,
    super.key
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  String? category;

  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 600,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _Time(
                    onStartSaved: onStartTimeSaved,
                    onStartValidation: onStartTimeValidate,
                    onEndSaved: onEndTimeSaved,
                    onEndValidation: onEndTimeValidate,
                  ),
                  SizedBox(height: 8.0),
                  _Contents(
                    onSaved: onContentSaved,
                    onValidation: onContentValidate,
                  ),
                  SizedBox(height: 8.0),
                  _Categories(
                    selectedColor: selectedColor,
                    onTap: (String color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                  SizedBox(height: 8.0),
                  _SaveButton(onPressed: onSavePressed),
                ],
              ),
            ),
          ),
        ));
  }

  void onStartTimeSaved(String? val) {
    if (val == null) {
      return;
    }
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력 해주세요!';
    }
    ;
    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }
    ;
    final time = int.parse(val);

    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요.';
    }
    return null;
  }

  void onEndTimeSaved(String? val) {
    if (val == null) {
      return;
    }

    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력 해주세요!';
    }
    ;
    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }
    ;

    final time = int.parse(val);

    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요.';
    }
    return null;
  }

  void onContentSaved(String? val) {
    if (val == null) {
      return;
    }
    content = val;
  }

  String? onContentValidate(String? val) {
    if (val == null) {
      return '값을 입력 해주세요!';
    };
    if (val == null) {
      return '내용을 입력해주세요!';
    };

    return null;
  }

  void onSavePressed() {
    final isValid = formKey.currentState!.validate();

    if (!isValid) return;
    if (isValid) formKey.currentState!.save();

    // final schedule = ScheduleTable(
    //   id: 999,
    //   startTime: startTime!,
    //   endTime: endTime!,
    //   content: content!,
    //   color: selectedColor,
    //   date: widget.selectedDay,
    //   createdAt: DateTime.now().toUtc(),
    // );

    // Navigator.of(context).pop(
    //   schedule,
    // );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidation;
  final FormFieldValidator<String> onEndValidation;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidation,
    required this.onEndValidation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              label: '시작시간',
              onSaved: onStartSaved,
              validator: onStartValidation,
            )),
            SizedBox(width: 16.0),
            Expanded(
                child: CustomTextField(
              label: '마감시간',
              onSaved: onEndSaved,
              validator: onEndValidation,
            )),
          ],
        ),
      ],
    );
  }
}

class _Contents extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidation;

  const _Contents({
    required this.onSaved,
    required this.onValidation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        onSaved: onSaved,
        validator: onValidation,
        expand: true,
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;

  const _Categories(
      {required this.selectedColor, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  onTap(e);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse(
                      'FF$e',
                      radix: 16,
                    )),
                    shape: BoxShape.circle,
                    border: e == selectedColor
                        ? Border.all(
                            color: Colors.black,
                            width: 4.0,
                          )
                        : null,
                  ),
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text('저장')),
        ),
      ],
    );
  }
}
