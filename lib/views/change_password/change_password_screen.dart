import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/views/authentication/authentication_screen.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_button.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/src/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static const id = "ChangePassword";

  @override
  Widget build(BuildContext context) {
    return ChangePasswordPage();
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kPopupBackgroundColor,
        elevation: 2,
        leading: IconButton(
          onPressed: () => {Navigator.of(context).pop()},
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.kBlackColor,
        ),
        title: Text(
          'Change password',
          style: TextConfigs.kText24w400Black,
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(47.w, 35.h, 48.w, 0),
              child: RoundedTextField(
                width: 342.w,
                height: 41.h,
                hintText: 'Current password',
                controller: context.read<AuthProvider>().currentPassword,
                onChanged: (value) => {},
                validator: RequiredValidator(errorText: 'Required!'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(47.w, 14.h, 48.w, 0),
              child: RoundedTextField(
                width: 342.w,
                height: 41.h,
                hintText: 'New password',
                controller: context.read<AuthProvider>().password,
                onChanged: (value) => {},
                validator: RequiredValidator(errorText: 'Required!'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(47.w, 14.h, 48.w, 0),
              child: RoundedTextField(
                width: 342.w,
                height: 41.h,
                hintText: 'Re-type new password',
                controller: context.read<AuthProvider>().retypePassword,
                onChanged: (value) => {},
                validator: RequiredValidator(errorText: 'Required!'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(55.w, 28.h, 55.w, 0),
              child: RoundedButton(
                width: 325.w,
                height: 43.h,
                text: const Text('Change password'),
                onPressed: () {
                  context.read<AuthProvider>().changePw(showSuccessDialog,showErrorDialog1,
                      showErrorDialog2,showErrorDialog3,showErrorDialog4,showErrorDialog5,showErrorDialog6);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showSuccessDialog(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Success. Do you want to log out?",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.only(right: 30.w),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("No"),
                              onPressed: () =>
                                  Navigator.pop(context, 'No'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor: AppColors
                                    .kButtonColor
                                    .withOpacity(0.35),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 141.w,
                        height: 43.h,
                        child: TextButton(
                            child: Text("Yes"),
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed(
                                AuthenticationScreen.id),
                            style: TextButton.styleFrom(
                              primary:
                              AppColors.kPopupBackgroundColor,
                              backgroundColor:
                              AppColors.kButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0.w),
                              ),
                            )),
                      )
                    ]),
                  ))
            ]));
  }
  void showErrorDialog1(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Empty data",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(63, 0, 5, 0),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor:
                                AppColors.kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      )
                    ]),
                  ))
            ]));
  }

  void showErrorDialog2(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Password is not matched!",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(63, 0, 5, 0),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor:
                                AppColors.kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      )
                    ]),
                  ))
            ]));
  }
  void showErrorDialog3(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Password must be more than 7 characters!",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(63, 0, 5, 0),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor:
                                AppColors.kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      )
                    ]),
                  ))
            ]));
  }
  void showErrorDialog4(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Password must not be matched with current password",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(63, 0, 5, 0),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor:
                                AppColors.kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      )
                    ]),
                  ))
            ]));
  }
  void showErrorDialog5(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Password must have at least 1 special characters!",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(63, 0, 5, 0),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor:
                                AppColors.kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      )
                    ]),
                  ))
            ]));
  }
  void showErrorDialog6(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Wrong current password",
              textAlign: TextAlign.center,
              style: TextConfigs.kText18w400Black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0.w))),
            actions: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(63, 0, 5, 0),
                        child: SizedBox(
                          width: 141.w,
                          height: 43.h,
                          child: TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              style: TextButton.styleFrom(
                                primary:
                                AppColors.kPopupBackgroundColor,
                                backgroundColor:
                                AppColors.kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0.w),
                                ),
                              )),
                        ),
                      )
                    ]),
                  ))
            ]));
  }
}
