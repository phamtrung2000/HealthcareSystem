import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback? onTextTap;

  const ClickableText({
    Key? key,
    required this.text,
    required this.onTextTap}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextConfigs.kText14w700Black.copyWith(
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = onTextTap,
      ),
      textAlign: TextAlign.center,
    );
  }
}