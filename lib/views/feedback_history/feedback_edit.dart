import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/menu_screen/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/feedback_model.dart';

class FeedbackEdit extends StatelessWidget {
  const FeedbackEdit(
    this.feedback, {
    Key? key,
  }) : super(key: key);
  final FeedbackModel feedback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit feedback', style: TextConfigs.kText24w400Black),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title', style: TextConfigs.kText18w400Black),
                    const SizedBox(height: 8),
                    TextField(
                      style: TextConfigs.kText18w400Black,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextConfigs.kText18w400Black,
                        fillColor: AppColors.kTextChatBackgroundColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 10,
                          borderSide: const BorderSide(
                            color: AppColors.kTextChatBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(thickness: 2, endIndent: 25, indent: 25),
                    Text('Description', style: TextConfigs.kText18w400Black),
                    const SizedBox(height: 8),
                    TextField(
                      maxLines: 8,
                      style: TextConfigs.kText18w400Black,
                      decoration: InputDecoration(
                        hintStyle: TextConfigs.kText18w400Black,
                        hintText: 'Description',
                        fillColor: AppColors.kTextChatBackgroundColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.kTextChatBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(thickness: 2, endIndent: 25, indent: 25),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_attach.svg',
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Add file',
                                style: TextConfigs.kText18w400Black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ...feedback.files != null
                        ? feedback.files!
                            .map(
                              (file) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
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
                                  GestureDetector(
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.close),
                                    ),
                                    onTap: () => feedback.files!.remove(file),
                                  ),
                                ],
                              ),
                            )
                            .toList()
                        : List.empty(),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  DefaultButton(
                    onTap: () => Navigator.pop(context),
                    title: 'Submit',
                    color: AppColors.kButtonColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
