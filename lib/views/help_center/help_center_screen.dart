
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/help_center/help_center.dart';
import 'package:flutter_mental_health/view_models/help_center/help_center.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/views/help_center//help_feedback_screen.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/view_models/help_center/help_center.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpCenterScreen extends StatelessWidget {
  static const id = "HelpCenter";
  const HelpCenterScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HelpCenterPage(title: 'Help Center');
  }
}

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HelpCenterPage> createState() => _HelpCenterState();
}

/*HelpCenterTopic _helpCenterTopic = HelpCenterTopic(topicID: '', tittle: '', listQuestions: []);

List<HelpCenterQuestion>? get helpCenterTopicList{
return _helpCenterTopic.listQuestions;
}*/
class _HelpCenterState extends State<HelpCenterPage> {

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
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          foregroundColor: AppColors.kBlackColor,
          backgroundColor: AppColors.kPopupBackgroundColor,
          title: Text(widget.title , style: TextConfigs.kText24w400Black,),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 36.w),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
            decoration: BoxDecoration(
              color: AppColors.kPopupBackgroundColor,
              borderRadius: BorderRadius.circular(29.5),
              border: Border.all(color: AppColors.kBlackColor),
            ),
            child: TextField(
              style: TextConfigs.kText18w400Black,
              decoration: InputDecoration(
                hintText: "Search",

                //icon: const Icon( Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          Consumer<HelpCenterProvider>(builder:(context, provider, index) {
            return ExpansionPanelList(

                expansionCallback: (int index, bool isExpanded){
                setState(() {
                  //helpCenterTopics[index].isExpanded=!helpCenterTopics[index].isExpanded;
                  provider.helpCenterTP[index].isExpanded=!provider.helpCenterTP[index].isExpanded;
                  print(provider.helpCenterTP[index].topicID);
                });
              },
              children:  provider.helpCenterTP.map((HelpCenterTopic item){
                return new ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return ListTile(
                          contentPadding: EdgeInsets.fromLTRB(19.w,0,0,0),
                          title: Text(item.tittle, style: TextConfigs.kText18w700BlueGrey,)
                      );
                    },
                    isExpanded: item.isExpanded,
                    body: ExpansionPanelList(

                      expansionCallback: (int index, bool isExpanded){
                        setState(() {
                          item.listQuestions[index].isExpanded=!item.listQuestions[index].isExpanded;

                        });
                      },
                      children: item.listQuestions.map((HelpCenterQuestion item) {
                        return new ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder: (BuildContext context, bool isExpanded){
                            return ListTile(
                              contentPadding: EdgeInsets.fromLTRB(28.w,0,0,0),
                              title: Text(item.question, style: TextConfigs.kText18w400Black),
                            );
                          },
                          isExpanded: item.isExpanded,

                          body: ListTile(
                            contentPadding: EdgeInsets.fromLTRB(28.w,0,0,0),
                            title: Text(item.answer, style: TextConfigs.kText18w400Black,),
                          ),
                        );
                      }).toList(),
                      animationDuration: Duration(milliseconds: 1000),

                    )
                );

              }).toList(),
              animationDuration: Duration(milliseconds: 1000),

            );
          }),
          Divider( thickness: 2,),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: ButtonStyle(minimumSize: MaterialStateProperty.all<Size>(Size(200.w,88.h)),
                    foregroundColor: MaterialStateProperty.all<Color>(AppColors.kBlackColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.sp))),
                  ),
                  onPressed: () async {
                    launch('tel: 0389 555 555');
                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone, size:31.sp, color: AppColors.kIconColor),
                      Text("Hotline", style: TextConfigs.kText16w700BlueGrey,)//TextStyle(height:2.h ,fontSize: 16.sp, fontWeight: FontWeight.normal,color: AppColors.kIconColor,), )
                    ],
                  ),

                ),
                VerticalDivider( thickness: 2,width: 0.h,),
                TextButton(
                  style: ButtonStyle(minimumSize: MaterialStateProperty.all<Size>(Size(200.w,88.h)),
                    foregroundColor: MaterialStateProperty.all<Color>(AppColors.kBlackColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.sp))),
                  ),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpFeedbackScreen()),);
                  } ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.mail, size:31.sp, color: AppColors.kIconColor),
                      Text("Email", style: TextConfigs.kText16w700BlueGrey,)
                    ],
                  ),

                ),
              ],
            ),),
          Divider( thickness: 2,),
        ],
      ),
    );
  }
}

