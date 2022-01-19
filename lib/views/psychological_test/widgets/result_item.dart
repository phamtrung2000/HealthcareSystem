import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_radio.dart';

class ResultItem extends StatefulWidget {
  final String contentQuestion;
  final int index;
  final int point;
  const ResultItem(
      {Key? key,
      required this.contentQuestion,
      required this.point,
      required this.index})
      : super(key: key);

  @override
  _ResultItemState createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  String _questionResult = "Never";

  @override
  void initState() {
    switch (widget.point) {
      case 1:
        {
          _questionResult = "Rarely";
        }
        break;
      case 2:
        {
          _questionResult = "Sometimes";
        }
        break;
      case 3:
        {
          _questionResult = "Often";
        }
        break;
      case 4:
        {
          _questionResult = "Always";
        }
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.kPopupBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kGreyBackgroundColor.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Question ' + (widget.index + 1).toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          Text(
            widget.contentQuestion,
            style: TextStyle(
              fontSize: 20.sp,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 40.w,
            ),
            child: const Divider(
              thickness: 2,
            ),
          ),
          Row(
            children: [
              CustomRadio<String>(
                margin: EdgeInsets.symmetric(vertical: 4.h),
                padding: EdgeInsets.all(2),
                iconColor: AppColors.kGreyBackgroundColor,
                size: 20.w,
                shape: BoxShape.circle,
                value: "true",
                groupValue: "true",
                borderRadius: BorderRadius.circular(4),
                onChanged: (String value) => setState(
                  () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  _questionResult,
                  style: TextStyle(
                    color: AppColors.kGreyBackgroundColor, //fix color
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
