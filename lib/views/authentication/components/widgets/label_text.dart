import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

// ignore: must_be_immutable
class LabelText extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  var selector = "";

  LabelText({Key? key, this.name = "", this.selector = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(name, style: TextConfigs.kText12w600Black),
      Text(selector, style: TextConfigs.kText12w700linkColor)
    ]);
  }
}
