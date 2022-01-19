import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/admin/admin_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_add_provider.dart';
import 'package:flutter_mental_health/views/admin/widgets/ban_mute_user.dart';
import 'package:flutter_mental_health/views/admin/widgets/hero_dialog_route.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_add_member.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class ContainerAddUsesr extends StatefulWidget {
  String fullName;
  String email;
  String id;
  String avatar;
  String roomId;
  ContainerAddUsesr(
      {required this.avatar,
      required this.id,
      required this.fullName,
      required this.email,
      required this.roomId,
      Key? key})
      : super(key: key);

  @override
  State<ContainerAddUsesr> createState() => _ContainerAddUsesrState();
}

class _ContainerAddUsesrState extends State<ContainerAddUsesr> {
  late List<String> listId;
  @override
  void initState() {
    listId = [...context.read<ChatRoomAddProvider>().listUserId];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HeroDialogRoute.id,
            arguments: BanMuteUserArguments(
                widget.email, widget.id, widget.fullName, widget.avatar));
      },
      child: Container(
        padding: EdgeInsets.only(top: 13.0.h),
        width: 414.w,
        height: 91.h,
        color: AppColors.kPopupBackgroundColor,
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0.w),
                  child: SizedBox(
                    width: 45.w,
                    height: 45.h,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatar),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fullName,
                        style: TextConfigs.kText20w400Black,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        widget.email,
                        style: TextConfigs.kText14w400Black,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // context.read<AdminProvider>().listUserId.add((element) => false),
                context
                        .read<ChatRoomAddProvider>()
                        .listUserId
                        .contains(widget.id)
                    ? Text(
                        "Added",
                        style: TextConfigs.kText18w700Grey,
                      )
                    : TextButton(
                        onPressed: () async {
                          print('add user');
                          await context
                              .read<ChatRoomAddProvider>()
                              .addUserToChatRoom(widget.roomId, widget.id);
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Success'),
                                  content: Text('add user success!'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close')),
                                  ],
                                );
                              });
                          context
                              .read<ChatRoomAddProvider>()
                              .listUserId
                              .add(widget.id);
                        },
                        child: Text(
                          "Add",
                          style: TextConfigs.kText18w700BlueGrey,
                        )),
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
