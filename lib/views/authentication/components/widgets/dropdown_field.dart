import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyDropDown extends StatefulWidget {
  String gender;
  // ignore: non_constant_identifier_names
  Function(String) OnDropdownItemChanged;
  // ignore: non_constant_identifier_names
  MyDropDown(
      {Key? key, required this.gender, required this.OnDropdownItemChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyDropDownState();
  }
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.kBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: DropdownButton<String>(
          isExpanded: true,
          value: widget.gender,
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          iconSize: 40.r,
          elevation: 16,
          style: const TextStyle(color: AppColors.kBorderColor),
          onChanged: (String? newValue) {
            widget.OnDropdownItemChanged(newValue!);
          },
          items: <String>['Male', 'Female', 'Others']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList()),
    );
  }
}
