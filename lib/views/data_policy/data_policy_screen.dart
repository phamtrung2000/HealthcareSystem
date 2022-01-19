import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class DataPolicyScreen extends StatelessWidget {
  static const id = "DataPolicy";
  const DataPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataPolicyPage(title: 'Data Policy');
  }
}

class DataPolicyPage extends StatefulWidget {
  const DataPolicyPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<DataPolicyPage> createState() => _DataPolicyState();
}

class _DataPolicyState extends State<DataPolicyPage> {
  void DataPolicy_Popup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 64.h,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            'Terms & Conditions and\ Privacy Policy',
                            textAlign: TextAlign.center,
                            style: TextConfigs.kText24w700Black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future:
                              rootBundle.loadString("assets/policy/policy.md"),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Markdown(data: snapshot.data);
                            }

                            return Center(
                              child: GenericLoadingAnimation(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 64.h,
                          width: 200.w,
                          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 10.h),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: AppColors.kButtonColor,
                            ),
                            child: Text(
                              'Ok',
                              style: TextConfigs.kText16w400White,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(47.h),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            centerTitle: true,
            foregroundColor: AppColors.kBlackColor,
            backgroundColor: AppColors.kPopupBackgroundColor,
            title: Text(
              widget.title,
              style: TextConfigs.kText24w400Black,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: rootBundle.loadString("assets/policy/policy.md"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(data: snapshot.data);
                  }

                  return Center(
                    child: GenericLoadingAnimation(),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 43.h,
                width: 342.w,
                margin: EdgeInsets.fromLTRB(36.w, 5.h, 36.w, 5.h),
                child: TextButton(
                  onPressed: DataPolicy_Popup,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: AppColors.kButtonColor,
                  ),
                  child: Text(
                    'Display Test',
                    style: TextConfigs.kText16w400White,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
