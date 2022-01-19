import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_provider.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_add_member.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_members.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/views/help_center//help_feedback_screen.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class ChatAdminController extends StatefulWidget {
  static const id = "ChatAdminController";

  ChatAdminController({required this.roomId, Key? key}) : super(key: key);
  String roomId;
  @override
  State<ChatAdminController> createState() => _ChatAdminControllerState();
}

class _ChatAdminControllerState extends State<ChatAdminController> {
  File? image;
  TextEditingController inputController = TextEditingController();

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47.h),
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          foregroundColor: AppColors.kBlackColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 165.w,
            height: 165.h,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0.w, 41.h, 0.w, 0.h),
            child: CircleAvatar(
              //borderRadius: BorderRadius.circular(90.sp),
              radius: 80.sp,
              backgroundImage: image != null
                  ? new FileImage(image!)
                  : AssetImage('assets/images/room.png') as ImageProvider,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(120.w, 5.h, 120.w, 0.h),
            child: TextButton(
                onPressed: () {
                  pickImage();
                },
                child: Text(
                  'Edit picture',
                  style: TextConfigs.kText14w400Black,
                )),
          ),
          Container(
            padding: EdgeInsets.only(left: 116.w),
            child: Text('Hashtag name', style: TextConfigs.kText24w400Black),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 350.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0.w, top: 20.h),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(ChatScreenMembers.id,
                              arguments:
                                  ChatAdminMemberArgument(widget.roomId));
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/users.svg'),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0.w),
                              child: Text(
                                'Member',
                                style: TextConfigs.kText24w400Black,
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatAdminControllerArgument {
  String roomId;
  ChatAdminControllerArgument(this.roomId);
}
