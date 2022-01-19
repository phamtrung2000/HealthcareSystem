// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';

// ignore: must_be_immutable
class RoundedButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  double marginVertical;
  double marginHozirontal;
  Color bgColor = AppColors.kButtonColor;
  Color textColor = AppColors.kPopupBackgroundColor;
  double btnWidth = double.infinity;
  final Function press;
  RoundedButton(
      {Key? key,
      this.name,
      this.marginHozirontal = 0,
      this.marginVertical = 0,
      this.bgColor = AppColors.kButtonColor,
      this.textColor = AppColors.kPopupBackgroundColor,
      this.btnWidth = double.infinity,
      required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: this.marginVertical, horizontal: this.marginHozirontal),
      width: btnWidth,
      height: 40.h,
      child: GFButton(
        color: bgColor,
        text: name,
        textStyle: TextConfigs.kText12w600Black,
        blockButton: true,
        shape: GFButtonShape.pills,
        onPressed: () {
          press();
        },
      ),
    );
  }
}
