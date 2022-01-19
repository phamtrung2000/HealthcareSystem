import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/widgets/rounded_button.dart';

class DataPolicy extends StatelessWidget {
  final String mdFileName;

  const DataPolicy({Key? key, required this.mdFileName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 150))
                    .then((value) {
                  return rootBundle.loadString('assets/documents/$mdFileName');
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      data: snapshot.data.toString(),
                    );
                  }
                  return const Center(child: GenericLoadingAnimation());
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoundedButton(
                        btnWidth: 150.w,
                        name: "Ok",
                        bgColor: Colors.transparent,
                        textColor: AppColors.kTouchableTextColor,
                        press: () => {Navigator.of(context).pop()}),
                  ]),
            )
          ],
        ),
      ),
    ));
  }
}
