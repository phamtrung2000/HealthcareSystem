import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/views/help_center//help_feedback_screen.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';



class ChatAdminScreen extends StatelessWidget {
  static const id = "chat_admin_screen";
  const ChatAdminScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChatAdminPage(title: '');
  }
}

class ChatAdminPage extends StatefulWidget {
  const ChatAdminPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ChatAdminPage> createState() => _ChatAdminPage();
}


class _ChatAdminPage extends State<ChatAdminPage> {

  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar:
      PreferredSize(preferredSize: Size.fromHeight(47.h),
        child: AppBar(
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          foregroundColor: AppColors.kBlackColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(widget.title , style: TextConfigs.kText24w400Black,),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 165.w,
            height: 165.h,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0.w,41.h,0.w, 0.h),
            child: CircleAvatar(
              //borderRadius: BorderRadius.circular(90.sp),
              radius: 80.sp,
              backgroundImage:image!=null
                  ? new FileImage(image!)
                  : AssetImage('assets/images/avatar.png') as ImageProvider,
            ),
          ),
          Container(
            margin:  EdgeInsets.fromLTRB(120.w,5.h,120.w, 0.h),
            child: TextButton(
                onPressed:(){pickImage();},
                child: Text('Edit picture', style: TextConfigs.kText14w400Black,)
            ),
          ),
          Container(
              margin:  EdgeInsets.fromLTRB(0.w,0.h,0.w,0.h),
              alignment: Alignment.center,
              child: Text('Chat room name', style: TextConfigs.kText24w400Black,)
          ),
          Container(
            margin:  EdgeInsets.fromLTRB(0.w,10.h,0.w,0.h),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: (){},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      child: Icon(Icons.groups_sharp, size:42.sp, color: AppColors.kIconColor),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 9.w),
                      child: Text('Members', style: TextConfigs.kText20w400Black,),
                    ),

                  ]
              ),
            ),
          ),
        ],
      ),);

  }
}
