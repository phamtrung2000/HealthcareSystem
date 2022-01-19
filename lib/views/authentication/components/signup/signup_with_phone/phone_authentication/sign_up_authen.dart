// import 'package:flutter/material.dart';
// // import 'package:flutter_mental_health/arguments/arguments.dart';

// import 'package:flutter_mental_health/configs/color_configs.dart';
// import 'package:flutter_mental_health/configs/text_configs.dart';
// import 'package:flutter_mental_health/models/authentication/otp_verify_model.dart';
// import 'package:flutter_mental_health/routes/app_routes.dart';
// import 'package:flutter_mental_health/services/data_repository.dart';
// import 'package:flutter_mental_health/views/Authentication/components/signup/signup_with_phone/phone_authentication/sign_up_box.dart';
// import 'package:flutter_mental_health/views/Authentication/components/widgets/countdown_time.dart';
// import 'package:flutter_mental_health/views/Authentication/components/widgets/label_text.dart';
// import 'package:flutter_mental_health/views/Authentication/components/widgets/rounded_button.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../create_password.dart';

// class SignUpAuthenticate extends StatefulWidget {
//   SignUpAuthenticate();
//   String phoneNum = "";
//   String hashKey = "";
//   static const id = "SignUpAuthenticate";

//   @override
//   State<StatefulWidget> createState() {
//     return OTPAuthenState();
//   }
// }

// class OTPAuthenState extends State<SignUpAuthenticate> {
//   late Map data;
//   String message = "";
//   String _otpValue = "";
//   @override
//   Widget build(BuildContext context) {
//     final argument = ModalRoute.of(context)!.settings.arguments
//         as SignUpAuthenticateArguments;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: (Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: AppColors.kPopupBackgroundColor,
//           title: (Title(
//               color: AppColors.kPopupBackgroundColor,
//               child: Text(
//                 "Sign up with phone number",
//                 style: TextConfigs.kText18w400Black,
//               ))),
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios_new),
//               color: AppColors.kBlackColor,
//               onPressed: () {
//                 Navigator.pop(context, false);
//               }),
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 50.h),
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 20.h,
//                   width: double.infinity,
//                 ),
//                 Center(
//                   child: Text("We sent you a code"),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                   width: double.infinity,
//                 ),
//                 Center(
//                   child: Text(
//                     argument.phoneNum,
//                     style:
//                         TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                   width: double.infinity,
//                 ),
//                 SignUpBoxes(
//                   onTextChanged: (String value) {
//                     setState(() {
//                       _otpValue = value;
//                     });
//                   },
//                 ),
//                 RoundedButton(
//                     marginHozirontal: 55.0.w,
//                     marginVertical: 30.0.h,
//                     name: "Next",
//                     press: () {
//                       OtpVerifyRequestModel model = OtpVerifyRequestModel(
//                           phoneNumber: argument.phoneNum,
//                           hash: argument.hashKey,
//                           otp: _otpValue);
//                       DataRepository().otpVerify(model).then((response) {
//                         setState(() {
//                           data = response;
//                           message = data['message'];
//                           if (message == "Success") {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pushNamed(CreatePassword.id,
//                                     arguments: CreatePasswordArguments(
//                                         argument.phoneNum));
//                           } else {
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) =>
//                                     const AlertDialog(
//                                       title: Text(
//                                           'Your OTP is incorrect! Please check again!'),
//                                     ));
//                           }
//                         });
//                       });
//                     }),
//                 Container(
//                     margin: EdgeInsets.symmetric(vertical: 10.h),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           LabelText(name: "Didn't receive the OTP? "),
//                           CountDownText()
//                         ])),
//                 Text("Resend code", style: TextConfigs.kText12w700linkColor)
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }

// class SignUpAuthenticateArguments {
//   final String hashKey;
//   final String phoneNum;
//   SignUpAuthenticateArguments(this.phoneNum, this.hashKey);
// }