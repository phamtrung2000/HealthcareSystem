import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/login_request_model.dart';
import 'package:flutter_mental_health/models/authentication/register_request_model.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/date_picker_widget.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/dropdown_field.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/rounded_button.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/text_field_input.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../tabcontrol.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({Key? key}) : super(key: key);
  static const id = "SignUpWithEmail";

  @override
  State<StatefulWidget> createState() {
    return _SignUpWithEmailState();
  }
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  late DateTime _date = DateTime.now();
  String _email = "";
  String _password = "";
  String _verifypassword = "";
  String fullname = "";
  String _gender = "Others";

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _verifypasswordcontroller = TextEditingController();
  final _fullnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: (Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.kPopupBackgroundColor,
          title: (Title(
              color: AppColors.kPopupBackgroundColor,
              child: Text(
                "Sign up with email",
                style: TextConfigs.kText18w400Black,
              ))),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: AppColors.kBlackColor,
              onPressed: () {
                Navigator.pop(context, false);
              }),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.h,
                  width: double.infinity,
                ),
                TextFieldInput(
                  validator: MultiValidator([
                    EmailValidator(errorText: "Email is invalid!"),
                    RequiredValidator(errorText: "Required!")
                  ]),
                  textinputType: TextInputType.emailAddress,
                  textController: _emailcontroller,
                  hinText: 'Email',
                  text: _email,
                  onTextChanged: (String text) {
                    setState(() {
                      _email = text;
                    });
                  },
                ),
                TextFieldInput(
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'password is required'),
                    MinLengthValidator(8,
                        errorText: 'password must be at least 8 digits long'),
                    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                        errorText:
                            'passwords must have at least one special character')
                  ]),
                  obcureText: true,
                  textinputType: TextInputType.visiblePassword,
                  hinText: "Password",
                  textController: _passwordcontroller,
                  text: _password,
                  onTextChanged: (String text) {
                    setState(() {
                      _password = text;
                    });
                  },
                ),
                TextFieldInput(
                  validator: (val) =>
                      MatchValidator(errorText: 'passwords do not match')
                          .validateMatch(val!, _password),
                  obcureText: true,
                  textinputType: TextInputType.visiblePassword,
                  hinText: "Verify Password",
                  textController: _verifypasswordcontroller,
                  text: _verifypassword,
                  onTextChanged: (String text) {
                    setState(() {
                      _verifypassword = text;
                    });
                  },
                ),
                TextFieldInput(
                  validator: RequiredValidator(errorText: "Required!"),
                  textinputType: TextInputType.text,
                  hinText: "Full name",
                  textController: _fullnamecontroller,
                  text: fullname,
                  onTextChanged: (String text) {
                    setState(() {
                      fullname = text;
                    });
                  },
                ),
                DatePickerWidget(
                  isAdminDatePicker: false,
                  date: _date,
                  onDateChanged: (DateTime date) {
                    setState(() {
                      _date = date;
                    });
                  },
                ),
                MyDropDown(
                  gender: _gender,
                  OnDropdownItemChanged: (String gender) {
                    setState(() {
                      _gender = gender;
                    });
                  },
                ),
                RoundedButton(
                    name: "Next",
                    marginVertical: 10.h,
                    press: () {
                      
                      RegisterRequestModel registermodel = RegisterRequestModel(
                        dateOfBirth: _date.toString(),
                        email: _email,
                        password: _password,
                        fullname: fullname,
                        gender: _gender,
                      );
                      DataRepository().register(registermodel).then((response) {
                        if (response) {
                          //Login success! Navigator to home screen
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const AlertDialog(
                                    title: Text('Register Success!'),
                                  ));
                        } else {
                          //Login falied!
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const AlertDialog(
                                    title: Text('This email has already in used! Please try again!'),
                                  ));
                        }
                      });
                    }),
                RoundedButton(
                    name: "Cancel",
                    marginVertical: 10.h,
                    bgColor: Colors.white,
                    textColor: AppColors.kGreyBackgroundColor,
                    press: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TabControl();
                          }))
                        }),
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
