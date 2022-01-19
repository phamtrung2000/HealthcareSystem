// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/admin/admin_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_add_provider.dart';
import 'package:flutter_mental_health/views/admin/components/admin_ban_user.dart';
import 'package:flutter_mental_health/views/admin/components/admin_mute_user.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_add_member.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';

class ChatScreenMembers extends StatefulWidget {
  static const id = "chat_screen_members";
  ChatScreenMembers({required this.roomId, Key? key}) : super(key: key);
  String roomId;

  @override
  State<ChatScreenMembers> createState() => _ChatScreenMembersState();
}

class _ChatScreenMembersState extends State<ChatScreenMembers> {
  List<String> listUserId = [];
  @override
  void initState() {
    context.read<ChatRoomAddProvider>().listUserId.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30.sp,
          color: AppColors.kBlackColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Members",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ChatAdminAddMember.id,
                  arguments: ChatAdminAddMemberArgument(widget.roomId));
            },
            child: const Icon(
              Icons.add,
              color: AppColors.kBlackColor,
              size: 30,
            ),
          )
        ],
        backgroundColor: AppColors.kPopupBackgroundColor,
      ),
      body: Container(
        color: const Color(0xffE5E5E5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 12, bottom: 12),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0.w),
                    ),
                    filled: true,
                    hintStyle: TextConfigs.kText18w400Grey
                        .copyWith(color: const Color(0xff212121)),
                    hintText: "Search",
                    fillColor: AppColors.kPopupBackgroundColor),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.kPopupBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child:
                      // ListView.builder(
                      //     padding: EdgeInsets.symmetric(vertical: 2.5.w),
                      //     itemCount: 20,
                      //     itemBuilder: (context, index) {
                      //       return const MemberWidget();
                      //     }),
                      FutureBuilder<List<User>>(
                          future: context
                              .read<ChatRoomAddProvider>()
                              .getListUserOfChatRoom(widget.roomId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return MemberWidget(
                                      fullname: snapshot.data![index].fullname,
                                      email: snapshot.data![index].email,
                                      role: snapshot.data![index].role,
                                      avt: snapshot.data![index].avatar,
                                      userId: snapshot.data![index].id,
                                      roomId: widget.roomId,
                                    );
                                  });
                            }
                          })),
            )
          ],
        ),
      ),
    );
  }
}

class MemberWidget extends StatelessWidget {
  final String userId;
  final String fullname;
  final int role;
  final String avt;
  final String email;
  final String roomId;
  const MemberWidget({
    Key? key,
    required this.fullname,
    required this.avt,
    required this.role,
    required this.email,
    required this.userId,
    required this.roomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (role != 1) {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r))),
            context: context,
            builder: ((builder) => bottomSheet(context, roomId)),
          );
        } else {}
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 19.w,
          vertical: (12.5).w,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avt),
              // backgroundColor: AppColors.kGreyBackgroundColor,
              radius: (45 / 2).w,
            ),
            SizedBox(
              width: 6.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullname,
                  style: TextConfigs.kText14w400Black.copyWith(fontSize: 20.sp),
                ),
                Text(role == 2 ? 'Member' : 'Admin',
                    style: TextConfigs.kText14w400Black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context, String roomId) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r))),
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 22.h, bottom: 4.h),
            child: Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: NetworkImage(avt),
                radius: (80 / 2).w,
              ),
            ),
          ),
          Center(
            child: Text(
              fullname,
              style: TextConfigs.kText24w400Black,
            ),
          ),
          Center(
            child: Text(
              email,
              style: TextConfigs.kText18w400BlackItalic,
            ),
          ),
          Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 22.0.w),
              child: TextButton(
                onPressed: () async {
                  await DataRepository().kickUserChatRoom(roomId, userId);
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('Kick user success!'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<ChatRoomAddProvider>()
                                      .listUserId
                                      .removeWhere((item) => item == userId);
                                  Navigator.pop(context);
                                },
                                child: Text('Close')),
                          ],
                        );
                      });

                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 370.w,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/kick_user.svg',
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 13.0.w),
                        child: Text('Kick user',
                            style: TextConfigs.kText20w400Black),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(left: 18.0.w),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AdminBanUser.id,
                  arguments: BanUserArguments(
                    userId,
                    fullname,
                    email,
                    avt,
                  ),
                );
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
          Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminMuteUser.id,
                      arguments: MuteUserArguments(
                        userId,
                        fullname,
                        email,
                        avt,
                      ));
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
                    SizedBox(
                      width: 370.w,
                      child: Padding(
                        padding: EdgeInsets.only(left: 49.0.w),
                        child: Text('Mute user',
                            style: TextConfigs.kText20w400Black),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 26.w, right: 26.w),
            child: Container(
              width: 370.w,
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
          ),
        ],
      ),
    );
  }
}

class ChatAdminMemberArgument {
  String roomId;
  ChatAdminMemberArgument(this.roomId);
}
