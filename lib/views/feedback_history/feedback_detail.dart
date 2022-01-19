import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/menu_screen/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'feedback_edit.dart';
import '../../models/feedback_model.dart';

class FeedbackDetail extends StatelessWidget {
  const FeedbackDetail(
    this.feedback, {
    Key? key,
  }) : super(key: key);
  final FeedbackModel feedback; // hange to state management later.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundAdmin,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Feedback', style: TextConfigs.kText24w400Black),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.white,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      feedback.title.toUpperCase(),
                      style: TextConfigs.kText24w700Black,
                    ),
                    Text(
                      DateFormat.yMMMd().format(feedback.date),
                      style: TextConfigs.kText14w400Black,
                    ),
                  ],
                ),
                Text(
                  feedback.description,
                  style: TextConfigs.kText16w400Black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          ...feedback.files != null
              ? feedback.files!
                  .map(
                    (file) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 4.0,
                      ),
                      child: SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_picture.svg',
                            ),
                            const SizedBox(width: 8),
                            Text(
                              file,
                              style: TextConfigs.kText18w400Black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
              : List.empty(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DefaultButton(
              onTap: () {
                pushNewScreen(context, screen: FeedbackEdit(feedback));
              },
              title: 'Edit',
              color: AppColors.kButtonColor,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
