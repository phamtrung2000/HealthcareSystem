// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_mental_health/arguments/arguments.dart';
// import 'package:flutter_mental_health/configs/color_configs.dart';
// import 'package:flutter_mental_health/configs/text_configs.dart';
// import 'package:flutter_mental_health/models/authentication/otp_signup_model.dart';
// import 'package:flutter_mental_health/routes/app_routes.dart';
// import 'package:flutter_mental_health/services/data_repository.dart';
// import 'package:flutter_mental_health/views/Authentication/components/widgets/rounded_button.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import '../../tabcontrol.dart';
// import 'phone_authentication/sign_up_authen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SignUpWithPhone extends StatefulWidget {
//   const SignUpWithPhone({Key? key}) : super(key: key);
//   static const id = "SignUpWithPhone";

//   @override
//   State<StatefulWidget> createState() {
//     return _SignUpWithPhoneState();
//   }
// }

// class _SignUpWithPhoneState extends State<SignUpWithPhone> {
//   PhoneNumber _phone = PhoneNumber(phoneNumber: '', isoCode: "VN");
//   final phoneEdittingController = TextEditingController();
//   late Map data;
//   String message = "";
//   late String hash;
//   @override
//   Widget build(BuildContext context) {
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
//               icon: const Icon(Icons.arrow_back_ios_new),
//               color: AppColors.kBlackColor,
//               onPressed: () {
//                 Navigator.pop(context, false);
//               }),
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.blueAccent),
//                           borderRadius: BorderRadius.circular(50.r)),
//                       child: Wrap(children: [
//                         InternationalPhoneNumberInput(
//                           maxLength: 10,
//                           onInputChanged: (PhoneNumber number) {
//                             setState(() {
//                               _phone = number;
//                             });
//                           },
//                           selectorConfig: const SelectorConfig(
//                             selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                           ),
//                           ignoreBlank: false,
//                           autoValidateMode: AutovalidateMode.disabled,
//                           selectorTextStyle: TextStyle(color: Colors.black),
//                           initialValue: _phone,
//                           textFieldController: phoneEdittingController,
//                           formatInput: false,
//                           keyboardType: const TextInputType.numberWithOptions(
//                               signed: true, decimal: true),
//                           inputBorder:
//                               OutlineInputBorder(borderSide: BorderSide.none),
//                         )
//                       ]),
//                     ),
//                     Text(
//                       (_phone.toString().length < 10)
//                           ? "Invalid phone number"
//                           : "",
//                       style: TextStyle(color: Colors.red, fontSize: 12),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                   width: double.infinity,
//                 ),
//                 RoundedButton(
//                     name: "Send code",
//                     press: () async {
//                       String parsablePhoneNumber =
//                           await PhoneNumber.getParsableNumber(_phone);                      
//                       String phonenum = ("0" +
//                               parsablePhoneNumber.replaceAll(RegExp(r' '), ''))
//                           .replaceAll(RegExp(r'^[+]'), '');
//                       OtpRequestModel model =
//                           OtpRequestModel(phoneNumber: phonenum);
//                       DataRepository().otp(model).then((response) {
//                         setState(() {
//                           data = response;
//                           message = data['message'];
//                           hash = data['data'];
//                         });
//                         if (message.isNotEmpty) {
//                           //Login success! Navigator to home screen
//                           Navigator.pushNamed(context, SignUpAuthenticate.id,
//                               arguments:
//                                   SignUpAuthenticateArguments(phonenum, hash));
//                         } else {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) =>
//                                   const AlertDialog(
//                                     title: Text(
//                                         'Your phone number is incorrect! Please check again!'),
//                                   ));
//                         }
//                       });
//                     }),
//                 SizedBox(
//                   height: 10.h,
//                   width: double.infinity,
//                 ),
//                 RoundedButton(
//                     name: "Cancel",
//                     marginVertical: 10.h,
//                     bgColor: Colors.transparent,
//                     textColor: AppColors.kGreyBackgroundColor,
//                     press: () => {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) {
//                             return const TabControl();
//                           }))
//                         }),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
