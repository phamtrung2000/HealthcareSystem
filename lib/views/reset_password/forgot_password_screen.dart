import 'package:flutter/material.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/views/reset_password/mobile_code_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_button.dart';
import 'package:flutter_mental_health/views/reset_password/widgets/rounded_textfield.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordArguments {
  final String email;
  final String hash;

  ForgotPasswordArguments({required this.email, required this.hash});
}

class ForgotPasswordScreen extends StatefulWidget {
  static const id = "ForgotPassword";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  void _onTextChanged(String email) {
    if (email.isNotEmpty) {
      _forgotController.value = TextEditingValue(
          text: email,
          selection: TextSelection.collapsed(offset: email.length)
      );
    }
  }

  String _response = "";
  void _onSendCode() async {
    if (_forgotController.text.isNotEmpty) {
      _response = await DataProvider().sendOTP(_forgotController.text);
      print('Sent OTP, check your email');

      Navigator.pushNamed(
          context,
          MobileCodeScreen.id,
          arguments: ForgotPasswordArguments(
              email: _forgotController.text,
              hash: _response)
      );
    }

    if (mounted) {
      setState(() {
        _forgotController.clear();
      });
    }
  }

  final TextEditingController _forgotController = TextEditingController();

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required!'),
    //PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Email must be valid')
  ]);

  @override
  Widget build(BuildContext context) {
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
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(36.w, 26.h, 36.w, 0),
              child: RoundedTextField(
                width: 342.w,
                height: 41.h,
                controller: _forgotController,
                validator: _emailValidator,
                onChanged: (value) => _onTextChanged(value),
                hintText: 'Email',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(70.w, 28.h, 80.w, 0),
              child: RoundedButton(
                width: 342.w,
                height: 41.h,
                text: const Text('Send code'),
                onPressed: () => _onSendCode(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}