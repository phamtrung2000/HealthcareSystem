import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/admin/components/admin_ban_user.dart';
import 'package:flutter_mental_health/views/admin/components/admin_mute_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowDialog extends StatelessWidget {
  static const id = "ShowDialgon";
  String string;
  ShowDialog({required this.string, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
            width: 400.w,
            height: 100.h,
            child: Center(child: Text('successful $string'))),
      ),
    );
  }
}
