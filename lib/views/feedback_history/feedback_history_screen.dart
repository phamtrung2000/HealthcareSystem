import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/models/feedback_model.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/views/community/widgets/topic_item.dart';
import 'package:flutter_mental_health/views/feedback_history/edit_feedback_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_screen.dart';
import 'package:flutter_mental_health/views/menu_screen/menu_screen.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FeedbackHistoryScreen extends StatefulWidget {
  static const id = "FeedbackHistoryScreen";
  const FeedbackHistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedbackState();
  }
}

class _FeedbackState extends State<FeedbackHistoryScreen> {
  Future<List<FeedbackModel>> _getFeedbackHistory(String userID) async {
    return await DataProvider().getFeedbackHistory(userID);
  }

  String _userID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_userID = '61b259d2e42516ff1e74d740';
    _userID = context.read<AuthProvider>().user.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kProfileInputColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()),);},
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        foregroundColor: AppColors.kBlackColor,
        backgroundColor: AppColors.kPopupBackgroundColor,
        title: Text(
          'Feedback History',
          style: TextConfigs.kText24w400Black,
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<List<FeedbackModel>>(
          future: _getFeedbackHistory(_userID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: GenericLoadingAnimation(),);
            }
            else {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackScreen(feedbackID: snapshot.data!.elementAt(index).feedbackID,)),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 5.w,
                            left: 5.w,
                            top: 5.h,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.kPopupBackgroundColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      snapshot.data!.elementAt(index).title,
                                      style: TextConfigs.kText18w700Black,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Text(
                                    FormatDateTime.formatterDay.format(snapshot.data!.elementAt(index).date),
                                    style: TextConfigs.kText14w400Black,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Text(
                                  snapshot.data!.elementAt(index).description,
                                  style: TextConfigs.kText14w400Black,
                                  maxLines: 3,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.w, 0.h, 50.w, 0.h),
                                child: TextButton(
                                  onPressed: null,
                                  child:Row(
                                    children: <Widget>[
                                      Icon(Icons.attach_file,size:30.sp, color: AppColors.kBlackColor,),
                                      Text(snapshot.data!.elementAt(index).files!.isEmpty ? '' : 'Attached files', style: TextConfigs.kText18w400Black,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 4.h,
                  ),
                  itemCount: snapshot.data!.length
              );
            }
          },
        )
      ),
    );
  }
}
