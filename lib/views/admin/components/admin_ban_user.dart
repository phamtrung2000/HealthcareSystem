import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/admin/user_ban_mute.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_dialog.dart';
import 'package:flutter_mental_health/views/authentication/components/widgets/date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBanUser extends StatefulWidget {
  AdminBanUser(
      {required this.fullName,
      required this.userId,
      required this.email,
      required this.avatar,
      Key? key})
      : super(key: key);
  static const id = "AdminBanUser";
  String userId;
  String fullName;
  String email;
  String avatar;
  @override
  _AdminBanUserState createState() => _AdminBanUserState();
}

class _AdminBanUserState extends State<AdminBanUser> {
  late DateTime _date = DateTime.now();
  String valueReason = 'Abuse';
  late String reason;
  late String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ban user',
          style: TextConfigs.kText24w400Black,
        ),
        centerTitle: true,
        backgroundColor: AppColors.kPopupBackgroundColor,
        elevation: 1.0.h,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: AppColors.kBlackColor)),
      ),
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 331.w,
            height: 257.h,
            margin: EdgeInsets.only(left: 41.0.w, top: 22.0.h),
            decoration: BoxDecoration(
                color: AppColors.kPopupBackgroundColor,
                borderRadius: BorderRadius.circular(25.r)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 21.0.h, bottom: 21.0.h),
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundColor: AppColors.kBackgroundAdmin,
                    backgroundImage: NetworkImage(widget.avatar),
                  ),
                ),
                Text(
                  widget.fullName,
                  style: TextConfigs.kText28w700Black,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.0.w, right: 21.w, top: 23.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email: ',
                        style: TextConfigs.kText18w400Black,
                      ),
                      Expanded(
                        child: Text(
                          widget.email,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextConfigs.kText18w400Black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 27.h,
            ),
            margin: EdgeInsets.only(left: 41.0.w),
            child: Row(
              children: [
                Text(
                  'Mute to',
                  style: TextConfigs.kText18w400Black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: DatePickerWidget(
                    isAdminDatePicker: true,
                    date: _date,
                    onDateChanged: (DateTime date) {
                      setState(
                        () {
                          _date = date;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 27.h),
            margin: EdgeInsets.only(left: 41.0.w),
            child: Row(
              children: [
                Text(
                  'Reason',
                  style: TextConfigs.kText18w400Black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: Container(
                    width: 254.w,
                    height: 40.h,
                    padding: EdgeInsets.only(left: 27.0.w),
                    decoration: BoxDecoration(
                        color: AppColors.kPopupBackgroundColor,
                        borderRadius: BorderRadius.circular(25.r)),
                    child: DropdownButton(
                      value: valueReason,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 30.0.r,
                      hint: Text(valueReason,
                          style: TextConfigs.kText14w400Black),
                      isExpanded: true,
                      items: <String>['Abuse', 'swearing']
                          .map(
                            (value) => DropdownMenuItem(
                                value: value, child: Text(value), onTap: () {}),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueReason = newValue.toString();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 28.0.w, top: 17.0.h),
            // color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(left: 41.0.w, top: 13.0.h),
            width: 331.w,
            height: 43.h,
            child: OutlinedButton(
              onPressed: () async {
                UserBanMute userBanMute = UserBanMute(
                    userId: widget.userId,
                    reason: valueReason,
                    banTime: _date,
                    type: "ban");
                await subMitBanUser(userBanMute);
                Navigator.of(context)
                    .pushNamed(ShowDialog.id, arguments: "ban");
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.kButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                ),
              ),
              child: Text(
                'submit',
                style: TextConfigs.kText12w400Black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 23.0.h),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ),
          )
        ],
      ),
    );
  }
}

class BanUserArguments {
  final String userId;
  final String name;
  final String email;
  final String avatar;
  BanUserArguments(
    this.userId,
    this.name,
    this.email,
    this.avatar,
  );
}

Future<void> subMitBanUser(userBanMute) async {
  // DataRepository().banUser(userBanMute: userBanMute);
}
