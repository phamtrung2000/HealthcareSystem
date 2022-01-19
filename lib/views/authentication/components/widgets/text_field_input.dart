import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TextFieldInput extends StatelessWidget {
  final TextEditingController textController;
  bool readOnly = false;
  // ignore: prefer_typing_uninitialized_variables
  var hinText;
  Color bgColor = Colors.transparent;
  // ignore: non_constant_identifier_names
  Color TextColor = AppColors.kGreyBackgroundColor;
  final String text;
  final Function(String) onTextChanged;
  final TextInputType textinputType;
  bool obcureText = false;
  String? Function(String?)? validator;

  TextFieldInput({
    Key? key,
    this.hinText,
    this.obcureText = false,
    this.readOnly = false,
    this.bgColor = Colors.transparent,
    // ignore: non_constant_identifier_names
    this.TextColor = AppColors.kGreyBackgroundColor,
    required this.text,
    required this.onTextChanged,
    required this.textController,
    required this.textinputType,
    required this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      width: double.infinity,
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: TextFormField(
          obscureText: obcureText,
          keyboardType: textinputType,
          validator: validator,
          onChanged: (value) {
            onTextChanged(value);
          },
          controller: textController,
          readOnly: readOnly,
          cursorColor: AppColors.kBlackColor,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.kBlackColor),
                  borderRadius: BorderRadius.circular(50.r)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
              hintText: hinText,
              hintStyle: TextStyle(color: TextColor)),
        ),
      ),
    );
  }
}
