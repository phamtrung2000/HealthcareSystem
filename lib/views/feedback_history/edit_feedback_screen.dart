import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/feedback_model.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_arguments.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_history_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_mental_health/views/help_center//help_center_screen.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';

import 'package:image_picker/image_picker.dart';

class EditFeedBackScreen extends StatelessWidget {
  static const id = "EditFeedBack";
  const EditFeedBackScreen({Key? key, required this.feedID}) : super(key: key);
  final String feedID;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EditFeedBackPage(title: 'Edit Feedback', feedbackID: feedID,);

  }
}

class EditFeedBackPage extends StatefulWidget {
  const EditFeedBackPage({Key? key, required this.title, required this.feedbackID}) : super(key: key);
  final String title;
  final String feedbackID;

  @override
  State<EditFeedBackPage> createState() => _EditFeedBackState();
}


class _EditFeedBackState extends State<EditFeedBackPage> {
  Future _addFile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        print('No image');
        return;
      }

      setState(() {
        _imageFiles.add(File(image.path));
      });
    }
    on PlatformException catch (e) {
      print('$e');
    }
  }

  void _removeFile(int i) {
    setState(() {
      _imageFiles.removeAt(i);
    });
  }

  void _onTitleChanged(String title) {
    if (title.length >= _minTitleLength) {
      _titleController.value = TextEditingValue(
          text: title,
          selection: TextSelection.collapsed(offset: title.length)
      );
    }
  }

  void _onDesChanged(String description) {
    if (description.length >= _minDesLength) {
      _descriptionController.value = TextEditingValue(
        text: description,
        selection: TextSelection.collapsed(offset: description.length)
      );
    }
  }

  void _onSubmit() async {
    FeedbackModel body = FeedbackModel(
        feedbackID: _model.feedbackID,
        title: _titleController.text,
        description: _descriptionController.text,
        userID: '',
        date: DateTime.now(),
        files: _imageFiles.isEmpty ? [] : _imageFiles.map((e) => e.path.toString()).toList()
    );

    _success = await DataProvider().editFeedback(_feedbackID, body);
    if (_success) {
      _titleController.clear();
      _descriptionController.clear();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 277.h,),
                backgroundColor: AppColors.kPopupBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                content: Container(
                  alignment: Alignment.center,
                  child: Text('Success',
                    style: TextConfigs.kText18w400Black,
                  ),
                ),
                actions: [
                  Center(
                    child: Container(
                      height: 43.h,
                      width: 296.w,
                      padding: EdgeInsets.fromLTRB(24.w,0.h,24.w, 5.h),
                      child: TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackHistoryScreen()),);},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r),),
                          backgroundColor: AppColors.kButtonColor,
                        ),
                        child: Text(
                          'OK',
                          style: TextConfigs.kText16w400White,
                        ),
                      ),
                    ),
                  ),
                ]);
          });
    }
  }

  void _getFeedback(String id) async {
    _model = await DataProvider().getFeedback(id);

    setState(() {
      _titleController.text = _model.title;
      _descriptionController.text = _model.description;
    });
  }

  final int _minTitleLength = 5;
  final int _minDesLength = 10;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  FeedbackModel _model = FeedbackModel(
    feedbackID: '',
    title: '',
    description: '',
    userID: '',
    files: [],
    date: DateTime.now()
  );

  String _feedbackID = "";

  bool _success = false;

  List<File> _imageFiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _feedbackID = widget.feedbackID;
    _getFeedback(_feedbackID);
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
      appBar:
      PreferredSize(preferredSize: Size.fromHeight(47.h),
        child: AppBar(
          leading: IconButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(feedbackID: _feedbackID,)),);},
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          foregroundColor: AppColors.kBlackColor,
          backgroundColor: AppColors.kPopupBackgroundColor,
          title: Text(widget.title , style: TextConfigs.kText24w400Black,),
        ),
      ),
      body: Column(
        children: [
          Expanded(

            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(36.w, 8.h, 0.h, 0.h),
                  child: Text(
                    'Title',
                    style: TextConfigs.kText18w400Black,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(36.w, 5.h, 36.h, 0.h),
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
                  decoration: BoxDecoration(
                    color: AppColors.kPopupBackgroundColor,
                    borderRadius: BorderRadius.circular(29.5.r),
                    border: Border.all(color: AppColors.kBlackColor),
                  ),
                  child: TextField(
                    style: TextConfigs.kText18w400Black,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      //icon: const Icon( Icons.search),
                      border: InputBorder.none,
                    ),
                    controller: _titleController,
                    onChanged: (value) => _onTitleChanged(value),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(58.w, 30.h, 58.w, 14.h),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 36.w),
                  child: Text(
                    'Description',
                    style: TextConfigs.kText18w400Black,
                  ),
                ),
                Container(
                  height: 200.h,
                  margin: EdgeInsets.fromLTRB(36.w, 8.h, 36.w, 0.h),
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h,),
                  decoration: BoxDecoration(
                    color: AppColors.kPopupBackgroundColor,
                    borderRadius: BorderRadius.circular(5.r),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(color: AppColors.kBlackColor, spreadRadius: 1),
                    ],
                  ),
                  child: TextFormField(
                    style: TextConfigs.kText18w400Black,
                    minLines: 1,
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                    ),
                    controller: _descriptionController,
                    onChanged: (value) => _onDesChanged(value),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(58.w, 22.h, 58.w, 0.h),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25.w, 0.h, 150.w, 12.h),
                  child: TextButton(
                    onPressed: _addFile,
                    child:Row(
                      children: <Widget>[
                        Icon(Icons.attach_file,size:30.sp, color: AppColors.kBlackColor,),
                        Text("Add file (.jpg, .png,...)", style: TextConfigs.kText18w400Black, )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, 12.h),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return ListView(
                        shrinkWrap: true,
                        children: _imageFiles.map((File files) {
                          return Card(
                              elevation: 2,
                              child: ListTile(
                                leading: const Icon(Icons.image,),
                                title: Text(files.uri.pathSegments.last, style: TextConfigs.kText18w400Black,),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close,),
                                  onPressed: () { _removeFile(_imageFiles.indexOf(files)); },
                                ),
                              )

                          );
                        }).toList(),

                      );
                    },
                  )
                ),

              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Divider(thickness: 2,),
            //Divider(thickness: 2,),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 43.h,
              width: 342.w,
              margin: EdgeInsets.fromLTRB(36.w, 2.h, 36.w, 12.h),
              child: TextButton(
                onPressed: _onSubmit,
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),), backgroundColor: AppColors.kButtonColor,),
                child: Text('Submit', style: TextConfigs.kText16w400White,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

