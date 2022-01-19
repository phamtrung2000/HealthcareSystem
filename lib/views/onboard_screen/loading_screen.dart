import 'package:flutter/material.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  static const id = "LoadingScreen";
  const LoadingScreen({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.fromLTRB(64.w, 229.h, 65.w, 230.h),
            child: const GenericLoadingAnimation(),
          ),
        ),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
      ),
    );
  }
}