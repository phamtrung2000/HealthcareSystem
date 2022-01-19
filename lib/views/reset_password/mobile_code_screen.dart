import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/views/reset_password/forgot_password_screen.dart';
import 'package:flutter_mental_health/views/reset_password/reset_password_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/clickable_text.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MobileCodeScreen extends StatefulWidget {
  static const id = "MobileCode";
  const MobileCodeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MobileCodeState();
  }
}

class _MobileCodeState extends State<MobileCodeScreen> {
  static const int _defaultTime = 46;
  int _start = _defaultTime;
  String _duration = '';

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      }
      else {
        if (mounted) {
          setState(() {
            --_start;
            _duration = '0:$_start';
          });
        }
      }
    });
  }

  void _onChanged(String value) {
    if (value.length >= _maxLength) {
      _otp = value;
    }
  }

  void _onVerify() async {
    String result = await DataProvider().verifyOTP(_recipient, _otp, _response);
    if (result.compareTo('Success') == 0) {
      print('OTP verified, you can change your password');

      Navigator.pushNamed(
          context,
          ResetPasswordScreen.id,
          arguments: ForgotPasswordArguments(email: _recipient, hash: '')
      );
    }
  }

  void _onResendCode() async {
    if (_start == 0) {
      _start = _defaultTime;
      _startTimer();

      _response = await DataProvider().sendOTP(_recipient);
    }
  }

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  final int _maxLength = 6;

  String _otp = "";
  String _response = "";
  String _recipient = "";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ForgotPasswordArguments;

    _recipient = args.email;
    if (_response.isEmpty) {
      _response = args.hash;
    }

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
          'Forgot password',
          style: TextConfigs.kText24w400Black,
        ),
        centerTitle: true,
        backgroundColor: AppColors.kBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(31.w, 48.h, 32.w, 0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(3.w, 0.0, 3.w, 0),
                    child: SizedBox(
                      width: 345.w,
                      height: 15.h,
                      child: Text(
                        'We sent you a code to',
                        style: TextConfigs.kText15w400Black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 18.h, 0, 0),
                    child: SizedBox(
                      width: 345.w,
                      height: 16.h,
                      child: Text(
                        _recipient,
                        style: TextConfigs.kText16w700Black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(3.w, 22.h, 6.w, 0),
                    child: PinCodeTextField(
                      appContext: context,
                      textStyle: TextConfigs.kText15w400Black,
                      length: 6,
                      keyboardType: TextInputType.number,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5.r),
                        fieldWidth: 47.w,
                        fieldHeight: 51.h,
                        activeColor: AppColors.kGreyTextTouchableColor,
                        activeFillColor: AppColors.kGreyTextTouchableColor,
                        inactiveColor: AppColors.kGreyTextTouchableColor,
                        inactiveFillColor: AppColors.kGreyTextTouchableColor,
                      ),
                      onChanged: (value) => _onChanged(value),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 25.h, 14.w, 0),
                    child: RoundedButton(
                      width: 325.w,
                      height: 43.h,
                      text: const Text('Next'),
                      onPressed: () => _onVerify(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 25.h, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Didn't receive the OTP?",
                          style: TextConfigs.kText14w400Black,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 0, 0, 0),
                          child: Text(
                            _duration,
                            style: TextConfigs.kText14w700Black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.0, 6.w, 0),
                    child: SizedBox(
                      width: 345.w,
                      height: 14.h,
                      child: ClickableText(
                        text: 'Resend code',
                        onTextTap: _onResendCode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
