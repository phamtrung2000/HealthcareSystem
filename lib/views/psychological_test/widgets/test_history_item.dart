//ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/views/psychological_test/test_history_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TestHistoryItem extends StatefulWidget {
  const TestHistoryItem(
      {Key? key,
      required this.point,
      required this.date,
      required this.onSeeMorePress})
      : super(key: key);
  final int point;
  final String date;
  final VoidCallback onSeeMorePress;
  @override
  _TestHistoryItemState createState() => _TestHistoryItemState();
}

class _TestHistoryItemState extends State<TestHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.h),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall test',
                style: TextStyle(fontSize: 18),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(widget.point.toString(),
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.bold)),
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: widget.onSeeMorePress,
                    child: Text(
                      'See more',
                      style:
                          TextStyle(fontSize: 14.sp, color: Color(0xCCCCCCCC)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
