import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/daily_checkin/add_description_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CheckInScreen createState() {
    return _CheckInScreen();
  }
}

class _CheckInScreen extends State<CheckInScreen> {
  static const id = "ChekckInScreen";

  String _feeling = "";

  void updateFeeling(String feeling) {
    setState(() => _feeling = feeling);
  }

  @override
  Widget todayFeeling() {
    String text = "Excellent";
    String imagePath = "assets/images/lol1.png";
    if (_feeling == "Excellent") {
      text = "Excellent";
      imagePath = "assets/images/lol1.png";
    }
    if (_feeling == "Happy") {
      text = "Happy";
      imagePath = "assets/images/smile1.png";
    }
    if (_feeling == "Normal") {
      text = "Normal";
      imagePath = "assets/images/neutral1.png";
    }
    if (_feeling == "Sad") {
      text = "Sad";
      imagePath = "assets/images/sad1.png";
    }
    if (_feeling == "Terriable") {
      text = "Terriable";
      imagePath = "assets/images/ill1.png";
    }
    return Container(
        child: Row(
      children: [
        Image(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          height: 54.h,
          width: 54.w,
        ),
        Container(
          margin: EdgeInsets.only(left: 12.w),
          child: Text(
            text,
            style: TextConfigs.kText24w400Black,
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    String today = formatter.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPopupBackgroundColor,
        elevation: 0,
        shape: Border(
            bottom: BorderSide(color: AppColors.kBackgroundColor, width: 3.w)),
        title: Text(
          "Daily checkin",
          style: TextConfigs.kText24w400Black,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.kBackgroundColor,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: AppColors.kPopupBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0.w),
                      bottomLeft: Radius.circular(10.0.w),
                    )),
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2300),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    todayDecoration: BoxDecoration(
                      color: AppColors.kTodayHighlightColor,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextConfigs.kText18w700Black,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.h),
                  width: 414.w,
                  height: 115.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0.w),
                    color: AppColors.kPopupBackgroundColor,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 27.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$today",
                          style: TextConfigs.kText18w700Black,
                        ),
                        Row(
                          children: [todayFeeling()],
                        )
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  width: 368.w,
                  height: 43.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0.w),
                      ),
                    ),
                    child: Text(
                      "Add checkin",
                      style: TextConfigs.kText16w400White,
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text(
                                  "Are you add check-in at \n $today?",
                                  textAlign: TextAlign.center,
                                  style: TextConfigs.kText18w400Black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0.w))),
                                actions: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20.w),
                                    child: Row(children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 30.w),
                                        child: SizedBox(
                                          width: 141.w,
                                          height: 43.h,
                                          child: TextButton(
                                              child: Text("No"),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              style: TextButton.styleFrom(
                                                primary: AppColors
                                                    .kPopupBackgroundColor,
                                                backgroundColor: AppColors
                                                    .kButtonColor
                                                    .withOpacity(0.35),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0.w),
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 141.w,
                                        height: 43.h,
                                        child: TextButton(
                                            child: Text("Yes"),
                                            onPressed: () async {
                                              final information =
                                                  await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddDescriptionScreen()),
                                                      ) ??
                                                      "Excellent";
                                              updateFeeling(information);
                                            },
                                            style: TextButton.styleFrom(
                                              primary: AppColors
                                                  .kPopupBackgroundColor,
                                              backgroundColor:
                                                  AppColors.kButtonColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0.w),
                                              ),
                                            )),
                                      )
                                    ]),
                                  )
                                ])),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
