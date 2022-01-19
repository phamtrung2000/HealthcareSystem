import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/components/admin_ban_user.dart';
import 'package:flutter_mental_health/views/admin/components/admin_mute_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BanMuteUser extends StatelessWidget {
  static const id = "BanMuteUser";
  String userId;
  String fullName;
  String avatar;
  String email;
  BanMuteUser(
      {required this.email,
      required this.avatar,
      required this.fullName,
      required this.userId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
          width: 414.w,
          height: 323.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 167.0.w),
                    child: Container(
                        width: 80.w,
                        height: 80.h,
                        // color: AppColors.kBlackColor,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(avatar))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 24.0.w),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ))
                ],
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(fullName, style: TextConfigs.kText24w600Black)),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    email,
                    style: TextConfigs.kText18w400BlackItalic,
                  )),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0.w),
                child: TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, AdminBanUser.id,
                        arguments:
                            BanUserArguments(userId, fullName, email, avatar));
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/block.svg'),
                      // Icon(Icons.block, color: AppColors.kIconColor),
                      SizedBox(width: 19.18.w),
                      Text('Ban user', style: TextConfigs.kText20w400Black)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 21.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0.w),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AdminMuteUser.id,
                        arguments:
                            MuteUserArguments(userId, fullName, email, avatar),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned(
                          left: 7.3.w,
                          child: SvgPicture.asset(
                            'assets/icons/chat.svg',
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/block.svg',
                        ),
                        SizedBox(width: 19.18.w),
                        Padding(
                          padding: EdgeInsets.only(left: 49.0.w),
                          child: Text('Mute user',
                              style: TextConfigs.kText20w400Black),
                        ),
                        SizedBox(width: 380.w)
                      ],
                    )),
              ),
              SizedBox(
                height: 26.h,
              ),
              Container(
                width: 362.w,
                height: 39.h,
                padding: EdgeInsets.only(left: 35.0.w),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                    'Cancle',
                    style: TextConfigs.kText12w400Black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BanMuteUserArguments {
  final String email;
  final String userId;
  final String fullName;
  final String avatar;
  BanMuteUserArguments(
    this.email,
    this.userId,
    this.fullName,
    this.avatar,
  );
}
