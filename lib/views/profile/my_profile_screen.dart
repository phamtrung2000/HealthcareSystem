import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/view_models/app_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/user/user_provider.dart';
import 'package:flutter_mental_health/utils/utils.dart';

class MyProfileScreen extends StatefulWidget {
  static const id = "MyProfileScreen";

  @override
  _MyProfileScreen createState() => _MyProfileScreen();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _MyProfileScreen extends State<MyProfileScreen> {
  var value;
  File? image;
  final baseUrl = AppConfigs.apiUrl;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  UserProvider? userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/images/backbtn.png'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  AppColors.kProfileBackgroundColorStart,
                  AppColors.kProfileBackgroundColorStart
                ],
              ),
            ),
            child: Container(
              child: Stack(children: [
                Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: AppColors.kPopupBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.w),
                                topLeft: Radius.circular(25.w),
                              )),
                          width: width,
                          height: 438.h,
                          child: Container(
                            margin: EdgeInsets.only(top: 60.h),
                            child: Column(
                              children: [
                                buildTextButton(),
                                buildFullNameInput(),
                                buildPasswordInput(),
                                Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    width: 329.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0.h),
                                        border: Border.all(
                                            color: Colors.black, width: 1.w)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Text(context
                                            .read<AuthProvider>()
                                            .user
                                            .gender),
                                        value: value,
                                        icon: Container(
                                            child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 40.sp,
                                        )),
                                        isExpanded: true,
                                        iconSize: 24.sp,
                                        style: TextConfigs.kText14w400Grey,
                                        onChanged: (newValue) {
                                          setState(() {
                                            value = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Male',
                                          'Female',
                                          'Other',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                buildButton(),
                              ],
                            ),
                          )),
                    ])),
                Positioned(
                  bottom: 379.h,
                  left: 135.w,
                  child: buildAvatar(),
                ),
              ]),
            ),
          ),
        ));
  }

  Widget buildTextButton() {
    return TextButton(
      onPressed: () {
        pickImage();
      },
      child: Text("Thay đổi ảnh", style: TextConfigs.kText14w400Black),
    );
  }

  Widget buildAvatar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(), primary: Colors.white),
      child: image != null
          ? ClipOval(
              child: Image.file(
              image!,
              fit: BoxFit.cover,
              width: 118.w,
              height: 118.h,
              alignment: Alignment.center,
            ))
          : ClipOval(
              child: Image.network(
                "${context.read<AuthProvider>().user.avatar}",
                fit: BoxFit.cover,
                width: 118.w,
                height: 118.h,
                alignment: Alignment.center,
              ),
            ),
      onPressed: () {
        pickImage();
      },
    );
  }

  Widget buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: SizedBox(
        width: 320.w,
        height: 43.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.kButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0.w),
              ),
            ),
            child: Text(
              "Save",
              style: TextConfigs.kText12w400White,
            ),
            onPressed: () {
              context.read<UserProvider>().updateUserProfile(() async {
                await Utils.successfulSubmission(
                    context, "Change Profile User Successfully");
                Navigator.pop(context);
              }, context.read<AuthProvider>().user.id, value,
                  Uri.parse(image!.path).toString());
            }),
      ),
    );
  }

  Widget buildFullNameInput() {
    return SizedBox(
      width: 329.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: TextFormField(
          enableInteractiveSelection: false,
          focusNode: AlwaysDisabledFocusNode(),
          initialValue: context.watch<AuthProvider>().user.fullname,
          style: TextConfigs.kText14w400Grey,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kProfileInputColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordInput() {
    return SizedBox(
      width: 329.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: TextFormField(
          enableInteractiveSelection: false,
          focusNode: AlwaysDisabledFocusNode(),
          initialValue: context.watch<AuthProvider>().user.fullname,
          style: TextConfigs.kText14w700Grey,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kProfileInputColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0.w),
            ),
          ),
        ),
      ),
    );
  }
}
