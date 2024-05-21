import 'package:flutter/material.dart';

import '../const/color.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 600,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
            child: Column(
              children: [
                _Time(),
                SizedBox(height: 8.0),
                _Contents(),
                SizedBox(height: 8.0),
                _Categories(
                  selectedColor: selectedColor,
                  onTap: (String color){
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                SizedBox(height: 8.0),
                _SaveButton(),

              ],
            ),
          ),
        ));
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
              label: '시작시간',
            )),
        SizedBox(width: 16.0),
        Expanded(
            child: CustomTextField(
              label: '마감시간',
            )),
      ],
    );
  }
}

class _Contents extends StatelessWidget {
  const _Contents({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;

  const _Categories({
    required this.selectedColor,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: (){
              onTap(e);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(int.parse(
                  'FF$e',
                  radix: 16,
                )),
                shape: BoxShape.circle,
                border: e == selectedColor ? Border.all(
                  color: Colors.black,
                  width: 4.0,
                ) : null,
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
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () {},
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

