import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_mental_health/views/help_center//help_center_screen.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';

class HelpFeedbackScreen extends StatelessWidget {
  static const id = "HelpFeedback";
  const HelpFeedbackScreen({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HelpFeedbackPage(title: 'Help - Feedback');

  }
}

class HelpFeedbackPage extends StatefulWidget {
  const HelpFeedbackPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HelpFeedbackPage> createState() => _HelpFeedbackState();
}


class _HelpFeedbackState extends State<HelpFeedbackPage> {

  void helpFeedbackSubmidSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 277.h,),
              backgroundColor: AppColors.kPopupBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterScreen()),);},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
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
  

  List<PlatformFile> HelpCenterFiles = const <PlatformFile>[];

  void helpFeedbackAddFile() async
  {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if(result != null) {
      setState(() {
        HelpCenterFiles = result.files;
      });
    } else {
      return;
    }

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
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterScreen()),);},
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
                  margin: EdgeInsets.fromLTRB(36.w, 33.h, 36.h, 0.h),
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
                  decoration: BoxDecoration(
                    color: AppColors.kPopupBackgroundColor,
                    borderRadius: BorderRadius.circular(29.5),
                    border: Border.all(color: AppColors.kBlackColor),
                  ),
                  child: TextField(
                    style: TextConfigs.kText18w400Black,
                    decoration: InputDecoration(
                      hintText: "Title",

                      //icon: const Icon( Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(58.w, 30.h, 58.w, 14.h),
                  child: Divider(
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
                    borderRadius: BorderRadius.circular(5),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Despription',

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(58.w, 22.h, 58.w, 0.h),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25.w, 0.h, 150.w, 12.h),
                  child: TextButton(

                    onPressed: helpFeedbackAddFile,
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
                  child:
                  ListView(
                    shrinkWrap: true,
                    children: HelpCenterFiles.map((PlatformFile files){
                      return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.image,),
                            title: Text(files.name, style: TextConfigs.kText18w400Black,),
                            trailing: IconButton(
                              icon: Icon(Icons.close,),
                              onPressed: (){removeFile(HelpCenterFiles.indexOf(files));},
                            ),
                          )

                      );
                    }).toList(),

                  ),
                ),

              ],
            ),
          ),
          Align(
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
                onPressed: helpFeedbackSubmidSuccess,
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),), backgroundColor: AppColors.kButtonColor,),
                child: Text('Submit', style: TextConfigs.kText16w400White,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void removeFile(int i){
    setState(() {
      HelpCenterFiles.removeAt(i);
    });
  }

}

