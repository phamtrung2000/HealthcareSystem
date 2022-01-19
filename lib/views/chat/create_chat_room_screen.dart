import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/views/help_center//help_feedback_screen.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class CreateChatRoomScreen extends StatelessWidget {
  static const id = "chat_chat_room_screen";

  const CreateChatRoomScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CreateChatRoomPage(title: '');
  }
}

class CreateChatRoomPage extends StatefulWidget {
  const CreateChatRoomPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CreateChatRoomPage> createState() => _CreateChatRoomPage();
}

class _CreateChatRoomPage extends State<CreateChatRoomPage> {
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
          centerTitle: true,
          foregroundColor: AppColors.kBlackColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            widget.title,
            style: TextConfigs.kText24w400Black,
          ),
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
                  'Add picture',
                  style: TextConfigs.kText14w400Black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(33.w, 24.h, 0.w, 0.h),
            child: Text('Chanel name', style: TextConfigs.kText16w400Black),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(27.w, 10.h, 27.h, 0.h),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
            decoration: BoxDecoration(
              color: AppColors.kPopupBackgroundColor,
              borderRadius: BorderRadius.circular(29.5.r),
              border: Border.all(color: AppColors.kBlackColor),
            ),
            child: TextField(
              controller: inputController,
              style: TextConfigs.kText18w400Black,
              decoration: InputDecoration(
                hintText: "Input",

                //icon: const Icon( Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 43.h,
              width: 342.w,
              margin: EdgeInsets.fromLTRB(36.w, 260.h, 36.w, 12.h),
              child: TextButton(
                onPressed: () async {
                  if (inputController.text.isNotEmpty) {
                    if (image != null) {
                      await context.read<ChatRoomProvider>().createRoom(
                          inputController.text,
                          context.read<AuthProvider>().user.role,
                          image!);
                    } else {
                      await context
                          .read<ChatRoomProvider>()
                          .createRoomWithOutAvatar(inputController.text,
                              context.read<AuthProvider>().user.role);
                    }
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Create room success!'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close')),
                            ],
                          );
                        });
                    Navigator.pop(context);
                  } else {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content:
                                Text('you haven\'t entered the room name!'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close')),
                            ],
                          );
                        });
                  }
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.kButtonColor,
                ),
                child: Text(
                  'Done',
                  style: TextConfigs.kText16w400White,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
