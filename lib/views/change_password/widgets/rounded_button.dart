import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class RoundedButton extends StatelessWidget {
  final double width;
  final double height;
  final Text? text;
  final VoidCallback? onPressed;

  const RoundedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed,
      child: Align(
        alignment: Alignment.center,
        child: text
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.kButtonColor),
        textStyle: MaterialStateProperty.all<TextStyle>(TextConfigs.kText16w400White),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          )
        ),
        minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
      ),
    );
  }
}