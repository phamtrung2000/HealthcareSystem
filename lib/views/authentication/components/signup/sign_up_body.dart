import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/label_text.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/rounded_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data_provicy.dart';
import 'signup_with_email/sign_up_email_body.dart';
import 'signup_with_phone/sign_up_with_phone.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundSignUp,
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: 14.0.h),
          child: Image.asset('assets/images/signup.png'),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            decoration: BoxDecoration(
                color: AppColors.kPopupBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedButton(
                    name: "Sign up with email",
                    marginVertical: 10.h,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpWithEmail();
                      }));
                    }),
                Container(
                  height: 43.0.h,
                ),
                // RoundedButton(
                //   name: "Sign up with phone number",
                //   marginVertical: 10.h,
                //   press: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) {
                //       return SignUpWithPhone();
                //     }));
                //   },
                // ),
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                ),
                LabelText(name: "By creating account, you are agreeing to our"),
                GestureDetector(
                    child: LabelText(
                        name: "",
                        selector: "Term & Conditions and Privacy Policy"),
                    onTap: () => {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DataPolicy(
                                  mdFileName: 'privacy_policy.md',
                                );
                              }),
                        })
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
