import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpBoxes extends StatefulWidget {
  final Function(String) onTextChanged;

  const SignUpBoxes({Key? key, required this.onTextChanged}) : super(key: key);
  @override
  _SignUpBoxesState createState() => _SignUpBoxesState();
}

class _SignUpBoxesState extends State<SignUpBoxes> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return (PinCodeTextField(
      onDone: (value) {
        widget.onTextChanged(value);
      },
      maxLength: 6,
      pinBoxHeight: 45.h,
      pinBoxWidth: 45.w,
      pinBoxColor: AppColors.kLightblueColor,
      pinTextStyle: TextConfigs.kText20w400Black,
      pinBoxRadius: 5.r,
      controller: _textEditingController,
      defaultBorderColor: Colors.transparent,
      hasTextBorderColor: Colors.transparent,
    ));
  }
}
