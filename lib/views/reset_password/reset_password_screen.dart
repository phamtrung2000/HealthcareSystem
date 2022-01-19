import 'package:flutter/material.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/views/authentication/authentication_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_button.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_textfield.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:intl/intl.dart';

import 'forgot_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const id = "ResetPassword";
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordState();
  }
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  void _onNewPassword(String value) {
    if (value.length >= _minLength) {
      _newController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length)
      );
    }
  }

  void _onRetype(String value) {
    if (value.length >= _minLength) {
      _retypeController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length)
      );
    }
  }
  
  void _onResetPassword() {
    if (_newController.text.compareTo(_retypeController.text) == 0) {
      DataProvider().resetPassword(_email, _newController.text);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 277.h),
            backgroundColor: AppColors.kPopupBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            content: Container(
              alignment: Alignment.center,
              child: Text(
                'Success',
                style: TextConfigs.kText18w400Black,
              ),
            ),
            actions: [
              Center(
                child: Container(
                  width: 296.w,
                  height: 43.h,
                  padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 5.h),
                  child: TextButton(
                    onPressed: () => { Navigator.of(context).pushNamed(AuthenticationScreen.id) },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      backgroundColor: AppColors.kButtonColor,
                    ),
                    child: Text(
                      'OK',
                      style: TextConfigs.kText16w400White,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      );
    }

    if (mounted) {
      setState(() {
        _newController.clear();
        _retypeController.clear();
      });
    }
  }

  static const int _minLength = 7;

  String _email = "";

  final TextEditingController _newController = TextEditingController();
  final TextEditingController _retypeController = TextEditingController();

  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required!'),
    MinLengthValidator(_minLength, errorText: 'Password must be at least 7 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Password must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ForgotPasswordArguments;

    _email = args.email;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            Navigator.of(context).pop()
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.kBlackColor,
        ),
        title: Text(
          'Reset password',
          style: TextConfigs.kText24w400Black,
        ),
        centerTitle: true,
        backgroundColor: AppColors.kBackgroundColor,
      ),
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(47.w, 31.h, 48.w, 0),
              child: RoundedTextField(
                width: 342.w,
                height: 41.h,
                controller: _newController,
                validator: _passwordValidator,
                onChanged: (value) => _onNewPassword(value),
                hintText: 'New password',
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(47.w, 14.h, 48.w, 0),
              child: RoundedTextField(
                width: 342.w,
                height: 41.h,
                controller: _retypeController,
                validator: _passwordValidator,
                onChanged: (value) => _onRetype(value),
                hintText: 'Re-type new password',
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44.w, 28.h, 45.w, 0),
              child: RoundedButton(
                width: 325.w,
                height: 43.h,
                text: const Text('Reset password'),
                onPressed: _onResetPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}