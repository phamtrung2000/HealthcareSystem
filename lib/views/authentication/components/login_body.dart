import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/login_request_model.dart';
import 'package:flutter_mental_health/models/authentication/login_with_fb_model.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/authentication/user_with_token.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/app_provider.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/rounded_button.dart';
import 'package:flutter_mental_health/views/Authentication/components/widgets/text_field_input.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_mental_health/views/reset_password/forgot_password_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late Map data;
  late String token = "";
  late User user;
  bool _isLoggedIn = false;
  Map _userObj = {};
  String _userName = "";
  late String _PassWord = "";
  final _textControllerPhone = TextEditingController();
  final _textControllerPassword = TextEditingController();

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.w,
                  height: 160.h,
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/images/logo_final.png',
                    ),
                  ),
                ),
                TextFieldInput(
                  validator: MultiValidator([
                    EmailValidator(errorText: "Please enter a valid email!"),
                    RequiredValidator(errorText: 'Email is required')
                  ]),
                  textinputType: TextInputType.text,
                  text: _userName,
                  onTextChanged: (String text) {
                    setState(() {
                      _userName = text;
                    });
                  },
                  textController: _textControllerPhone,
                  hinText: "abc@gmail.com",
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
                    text: _PassWord,
                    onTextChanged: (String text) {
                      setState(() {
                        _PassWord = text;
                      });
                    },
                    textController: _textControllerPassword),
                RoundedButton(
                  name: "Login",
                  marginVertical: 10.h,
                  //login event
                  press: () {
                    // context.read<AuthProvider>().onChange(false);
                    // Navigator.pushReplacementNamed(
                    var userName = _userName;
                    LoginRequestModel model = LoginRequestModel(
                      email: userName,
                      password: _PassWord,
                      token: context.read<AppProvider>().deviceToken,
                    );
                    DataRepository().login(model).then(
                      (response) async {
                        data = response;
                        if (response.isNotEmpty) {
                          //Login success! Navigator to home screen
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) =>
                          //       const AlertDialog(
                          //     title: Text(
                          //         'Login Success! Navigating to Home Screen!'),
                          //   ),
                          // );
                          user = User.fromJson(data["user"]);
                          token = data["token"];
                          context.read<AuthProvider>().setUser(user, token);
                          // UserToken newuser =
                          //     UserToken(user: user, token: token);
                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.id,
                            // arguments: newuser,
                          );
                        } else {
                          //Login falied!
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const AlertDialog(
                              title: Text('Login Failed!'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                  width: double.infinity,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).pushNamed(ForgotPasswordScreen.id)
                  },
                  child: Text("Forgot password?",
                      style: TextConfigs.kText12w600Black),
                ),
                SizedBox(
                  height: 20.h,
                  width: double.infinity,
                ),
                RoundedButton(
                    name: "Log in with Facebook",
                    marginVertical: 10.h,
                    press: () async {
                      context.read<AuthProvider>().onChange(true);
                      final result = await FacebookAuth.i.login(permissions: [
                        "public_profile",
                        "email",
                        'user_birthday',
                        'user_gender'
                      ]);
                      if (result.status == LoginStatus.success) {
                        final requestData = await FacebookAuth.i.getUserData(
                          fields:
                              "email, name, picture.width(200),birthday,gender",
                        );
                        setState(() {
                          _userObj = requestData;
                        });
                        LoginWithFbRequestModel model = LoginWithFbRequestModel(
                            email: _userObj["email"],
                            fullname: _userObj["name"],
                            avatar: _userObj["picture"]["data"]["url"],
                            dateOfBirth: DateTime.now().toString(),
                            gender: "Other");
                        DataRepository().loginWithFb(model).then((value) {
                          if (value.isNotEmpty) {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) =>
                            //         const AlertDialog(
                            //           title: Text('Login Success!'),
                            //         ));
                            var user = User.fromJson(value["user"]);
                            token = value["token"];
                            context.read<AuthProvider>().setUser(user, token);
                            UserToken newuser =
                                UserToken(user: user, token: token);
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.id,
                              arguments: newuser,
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertDialog(
                                      title: Text('Login Failed!'),
                                    ));
                          }
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void fetchUser() {}
