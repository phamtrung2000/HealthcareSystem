import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/views/psychological_test/psychological_test_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/widgets/radio_group.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionWidget extends StatefulWidget {
  final int index;
  final String contentQuestion;
  final int point;
  const QuestionWidget(
      {Key? key,
      required this.contentQuestion,
      required this.index,
      this.point = 0})
      : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  QuestionResult questionResult = QuestionResult.Sometimes;
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Question ' + (widget.index + 1).toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          Text(
            widget.contentQuestion,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 13.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 13.h,
          ),
          RadioGroup(
              size: 20.w,
              style: TextStyle(fontSize: 13.sp),
              shape: BoxShape.circle,
              items: [...QuestionResult.values.map((e) => e.name).toList()],
              onCheckChanged: (val) {
                setState(() {
                  questionResult = QuestionResultExtension.fromName(val);
                });
              })
        ],
      ),
    );
  }
}
