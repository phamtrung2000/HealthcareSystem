import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class RoundedTextField extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final bool obscureText;

  const RoundedTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.hintText,
    this.obscureText = false,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: obscureText,
        style: TextConfigs.kText18w400Grey,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.kBlackColor,
            ),
          ),
          hintText: hintText,
          hintStyle: TextConfigs.kText18w400Grey,
        ),
      )
    );
  }
}