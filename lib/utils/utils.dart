import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Utils {
  static Future successfulSubmission(
      BuildContext context, String content) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 35.w,
              vertical: 250.h,
            ),
            backgroundColor: AppColors.kBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Center(
              child: Text(
                content,
                style: TextConfigs.kText18w400Black,
              ),
            ),
            actions: [
              Center(
                child: Container(
                  height: 43.h,
                  width: 220.w,
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: AppColors.kPopupBackgroundColor,
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: AppColors.kBlackColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ]);
      },
    );
  }
}
