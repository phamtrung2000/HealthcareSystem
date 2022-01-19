import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  final DateTime date;
  final bool isAdminDatePicker;
  const DatePickerWidget(
      {Key? key,
      required this.onDateChanged,
      required this.date,
      required this.isAdminDatePicker})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DateTimePickerState();
  }
}

class DateTimePickerState extends State<DatePickerWidget> {
  final controller = TextEditingController();
  //convert date to string
  String getText() {
    // ignore: unnecessary_null_comparison
    if (widget.date == null) {
      return 'Select Date';
    } else {
      return DateFormat('yyyy/MM/dd').format(widget.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isAdminDatePicker
        ? Container(
            width: 254.w,
            height: 40.h,
            decoration: BoxDecoration(
                color: AppColors.kPopupBackgroundColor,
                borderRadius: BorderRadius.circular(50.r)),
            padding: EdgeInsets.only(left: 27.0.w),
            // width: double.infinity,
            child: TextField(
              readOnly: true,
              onTap: () => pickdate(context),
              enabled: true,
              cursorColor: AppColors.kBlackColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                // focusedBorder: OutlineInputBorder(
                //   borderSide: const BorderSide(color: AppColors.kBorderColor),
                //   borderRadius: BorderRadius.circular(50.r),
                // ),
                hintText:
                    widget.date == DateTime.now() ? "Datetime" : getText(),
                hintStyle:
                    const TextStyle(color: AppColors.kGreyBackgroundColor),
                suffixIcon: Icon(Icons.date_range),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50.r)),
            margin: EdgeInsets.only(bottom: 20.h),
            width: double.infinity,
            child: TextField(
              readOnly: true,
              onTap: () => pickdate(context),
              enabled: true,
              cursorColor: AppColors.kBlackColor,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.kBorderColor),
                      borderRadius: BorderRadius.circular(50.r)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.kBorderColor),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  hintText: widget.date == DateTime.now()
                      ? "Date of birth"
                      : getText(),
                  hintStyle:
                      const TextStyle(color: AppColors.kGreyBackgroundColor)),
            ),
          ));
  }

  //show pickdatetime dialog
  Future pickdate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1979),
        lastDate: DateTime(2100));
    if (newDate == null) {
      return;
    } else {
      widget.onDateChanged(newDate);
    }
  }
}
