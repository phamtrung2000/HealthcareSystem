// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/utils/utils.dart';
import 'package:flutter_mental_health/view_models/app_provider.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/daily_checkin/daily_checkin_provider.dart';
import 'package:flutter_mental_health/views/daily_checkin/checkin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDescriptionScreen extends StatefulWidget {
  static const id = "add_description_screen";

  const AddDescriptionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddDescriptionScreen createState() {
    return _AddDescriptionScreen();
  }
}

class _AddDescriptionScreen extends State<AddDescriptionScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String feeling = "Excellent";
  DailyCheckinProvider? dailyCheckinProvider;

  @override
  void didChangeDependencies() {
    dailyCheckinProvider =
        Provider.of<DailyCheckinProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    String today = formatter.format(DateTime.now());
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/ButtonX.png'),
          onPressed: () => Navigator.pop(context, feeling),
        ),
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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Column(
              children: [
                Text(
                  "How are you today ?",
                  style: TextConfigs.kText24w400Black,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "$today",
                    style: TextConfigs.kText18w400Black,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                feeling = "Excellent";
                                print(feeling.runtimeType);
                              },
                              child: Column(children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/lol1.png",
                                  ),
                                  fit: BoxFit.cover,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.h),
                                  child: Text(
                                    "Excellent",
                                    style: TextConfigs.kText16w400Black,
                                  ),
                                )
                              ])),
                        ),
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                feeling = "Happy";
                              },
                              child: Column(children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/smile1.png",
                                  ),
                                  fit: BoxFit.cover,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.h),
                                  child: Text(
                                    "Happy",
                                    style: TextConfigs.kText16w400Black,
                                  ),
                                )
                              ])),
                        ),
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                feeling = "Normal";
                              },
                              child: Column(children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/neutral1.png",
                                  ),
                                  fit: BoxFit.cover,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.h),
                                  child: Text(
                                    "Normal",
                                    style: TextConfigs.kText16w400Black,
                                  ),
                                )
                              ])),
                        ),
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                feeling = "Sad";
                              },
                              child: Column(children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/sad1.png",
                                  ),
                                  fit: BoxFit.cover,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.h),
                                  child: Text(
                                    "Sad",
                                    style: TextConfigs.kText16w400Black,
                                  ),
                                )
                              ])),
                        ),
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                feeling = "Terriable";
                              },
                              child: Column(children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/ill1.png",
                                  ),
                                  fit: BoxFit.cover,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.h),
                                  child: Text(
                                    "Terriable",
                                    style: TextConfigs.kText16w400Black,
                                  ),
                                )
                              ])),
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h, right: 36.w, left: 36.w),
                  child: TextField(
                    maxLines: 11,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextConfigs.kText18w400Grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0.w),
                      ),
                    ),
                  ),
                ),
                if (!isKeyboard)
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: SizedBox(
                      width: 342.w,
                      height: 43.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.kButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.w),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<DailyCheckinProvider>()
                              .submitDailyCheckin(
                            () async {
                              await Utils.successfulSubmission(
                                  context, "Submit Daily Checkin Successfully");
                              Navigator.pop(context, feeling);
                            },
                            context.read<AuthProvider>().user.id,
                            DateTime.now(),
                            feeling,
                            _descriptionController.text,
                          );
                        },
                        child: Text(
                          "Submit",
                          style: TextConfigs.kText16w400White,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
