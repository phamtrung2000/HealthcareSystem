import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/widgets/ban_mute_user.dart';
import 'package:flutter_mental_health/views/admin/widgets/hero_dialog_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerUsesr extends StatelessWidget {
  String fullName;
  String email;
  String id;
  String avatar;
  ContainerUsesr(
      {required this.avatar,
      required this.id,
      required this.fullName,
      required this.email,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HeroDialogRoute.id,
            arguments: BanMuteUserArguments(email, id, fullName, avatar));
      },
      child: Container(
        padding: EdgeInsets.only(top: 13.0.h),
        width: 414.w,
        height: 91.h,
        color: AppColors.kPopupBackgroundColor,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0.w),
                  child: SizedBox(
                    width: 61.w,
                    height: 61.h,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: TextConfigs.kText24w400Black,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        email,
                        style: TextConfigs.kText14w400Black,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0.h),
              child: Container(height: 1.h, color: AppColors.kDivider),
            ),
          ],
        ),
      ),
    );
  }
}
