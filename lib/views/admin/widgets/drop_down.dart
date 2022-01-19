import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDown extends StatelessWidget {
  String hint;
  bool isPostScreen;
  DropDown({
    required this.hint,
    required this.isPostScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: SizedBox(),
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 30.0.r,
      hint: isPostScreen
          ? Text(
              hint,
            )
          : Padding(
              padding: EdgeInsets.only(left: 27.0.w),
              child: Text(
                hint,
                style: TextConfigs.kText14w400Black,
              ),
            ),
      isExpanded: true,
      items: <String>[hint]
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      onChanged: (_) {},
    );
  }
}
