import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  String text;
  final VoidCallback onClicked;
  Color color;
  Button({
    required this.onClicked,
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onClicked,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(widget.color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
        ),
      ),
      child: Text(
        widget.text,
        style: TextConfigs.kText12w400Black,
      ),
    );
  }
}
