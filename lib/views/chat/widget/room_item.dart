import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/views/chat/widget/pop_menu_button.dart';
import 'package:flutter_mental_health/views/chat/widget/pop_menu_room.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class RoomItem extends StatelessWidget {
  RoomItem(
      {required this.roomId,
      required this.roomName,
      required this.avatar,
      Key? key})
      : super(key: key);
  String roomName;
  String avatar;
  String roomId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // color: Colors.grey[400],
            height: 74.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 11.h),
                        width: 60.w,
                        height: 60.h,
                        child: avatar != ""
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${DataRepository().baseUrl}' '$avatar'))
                            : CircleAvatar(
                                child: Image.asset('assets/images/room.png'),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18.0.w),
                        child: Text(
                          roomName,
                          style: TextConfigs.kText24w400Black,
                        ),
                      ),
                      Spacer(),
                      context.read<AuthProvider>().user.role == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: 10.0.w),
                              child: MyPopRoomButton(roomId: roomId),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 11.0.h),
                  child: Container(height: 1.h, color: AppColors.kDivider),
                ),
              ],
            )),
      ],
    );
  }
}
