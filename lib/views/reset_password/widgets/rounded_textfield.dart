import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class RoundedTextField extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final bool obscureText;

  RoundedTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onChanged,
    this.obscureText = false,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Form(
        child: TextFormField(
          controller: controller,
          validator: validator,
          onChanged: (value) => onChanged(value),
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.bottom,
          style: TextConfigs.kText18w400Grey,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: AppColors.kBlackColor),
              borderRadius: BorderRadius.circular(25.r),
            ),
            hintText: hintText,
            hintStyle: TextConfigs.kText18w400Grey,
          ),
        ),
      )
    );
  }
}