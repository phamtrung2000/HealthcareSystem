import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/routes/app_routes.dart';
import 'package:flutter_mental_health/views/chat/chat_room_admin_screen.dart';
import 'package:flutter_mental_health/views/chat/chat_room_list.dart';
import 'package:flutter_mental_health/views/chat/create_chat_room_screen.dart';
import 'package:flutter_mental_health/views/reports/report_problem/report_problem_screen.dart';
import 'package:flutter_mental_health/views/search_page/search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'chat/chat_screen.dart';
import 'community/community_screen.dart';
import 'daily_checkin/checkin_screen.dart';
import 'menu_screen/menu_screen.dart';

class HomeScreen extends StatelessWidget {
  static const id = "HomeScreen";

  HomeScreen({Key? key}) : super(key: key);
  final List<Widget> _screens = [
    const CommunityScreen(),
    const ChatRoomList(),
    const CheckInScreen(),
    //const TempScreen1(),
    const SearchPage(),
    const MenuScreen(),
  ];
  final _navBarsItems = <PersistentBottomNavBarItem>[
    PersistentBottomNavBarItem(
      icon: Transform.scale(
        scale: 2.0,
        child: Image.asset(
          'assets/icons/ic_community.png',
          height: 15.w,
          width: 15.w,
        ),
      ),
      textStyle: TextConfigs.kText11w700Border,
      title: "Community",
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        onGenerateRoute: AppRoutes().onGenerateRoute,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: Transform.scale(
        scale: 2.0,
        child: Image.asset(
          'assets/icons/ic_chat.png',
          height: 15.w,
          width: 15.w,
        ),
      ),
      textStyle: TextConfigs.kText11w700Border,
      title: "Chat",
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        onGenerateRoute: AppRoutes().onGenerateRoute,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: Transform.scale(
        scale: 2.0,
        child: Image.asset(
          'assets/icons/ic_checkin.png',
          height: 15.w,
          width: 15.w,
        ),
      ),
      textStyle: TextConfigs.kText11w700Border,
      title: "Daily Checkin",
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        onGenerateRoute: AppRoutes().onGenerateRoute,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: Transform.scale(
        scale: 2.0,
        child: Image.asset(
          'assets/icons/ic_search.png',
          height: 15.w,
          width: 15.w,
        ),
      ),
      textStyle: TextConfigs.kText11w700Border,
      title: "Search",
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        onGenerateRoute: AppRoutes().onGenerateRoute,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: Transform.scale(
        scale: 2.0,
        child: Image.asset(
          'assets/icons/ic_menu.png',
          height: 15.w,
          width: 15.w,
        ),
      ),
      textStyle: TextConfigs.kText11w700Border,
      title: "Menu",
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        onGenerateRoute: AppRoutes().onGenerateRoute,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _screens,
      items: _navBarsItems,
      confineInSafeArea: true,
      popActionScreens: PopActionScreensType.all,
      backgroundColor: AppColors.kPopupBackgroundColor,
      navBarHeight: 56.h,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      padding: NavBarPadding.only(
        bottom: 3.h,
      ),
      bottomScreenMargin: 56.h,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}

//region temp screeen, will be deleted soon
class TempScreen1 extends StatefulWidget {
  const TempScreen1({Key? key}) : super(key: key);

  @override
  State<TempScreen1> createState() => _TempScreen1State();
}

class _TempScreen1State extends State<TempScreen1> {
  int createdAt = 0;
  String message = "";
  Socket? socket;
  String ackMessage = "";

  @override
  void initState() {
    socket = io(
      /**
       * url: g???m apiUrl v?? namespace
       * Format: "<AppConfigs.apiUrl><namespace>"
       * V?? d???: N???u BE g???i io.of("/comments")
       * Th?? ??? ????y namespace l?? "/comments"
       */
      "${AppConfigs.apiUrl}/comments",
      /**
       * Option: ????? v???y l?? ???????c, n???u set th??m c??c option kh??c th?? th??m v??o
       * ?????c docs c???a lib socket_io_client ????? bi???t th??m chi ti???t
       */
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({
            'token':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWE0OWFmNTYzMDBlYjNjNDU1YjBmM2UiLCJpYXQiOjE2MzgxNzgwNjh9.IA1jmhLxeK50tE0ZZ2w8jhO5NMZC3vFKbjd1hDR02WU'
          })
          .build(),
    );

    //connect ?????n server
    socket!.connect().onError((data) => print(data));

    /**
     * on event "test"
     * X???y ra khi server emit event "test"
     * data: data g???i t??? server, th?????ng l?? d???ng Map<String,dynamic>
     */
    socket!.on("test", (data) {
      print("received $data from socket");
      setState(() {
        message = data["text"];
        createdAt = data["createdAt"];
      });
    });

    socket!.on('commentReceived', (data) => {print(data)});

    super.initState();
  }

  _closeSocket() {
    socket?.disconnect();
    socket?.close();
  }

  @override
  void dispose() {
    _closeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Test socketio"),
            Text(message),
            Text(
                "Created at ${DateTime.fromMillisecondsSinceEpoch(createdAt)}"),
            ElevatedButton(
              onPressed: () {
                /**
                 * emitWithAck:
                 *  Param1: t??n event
                 *  Param2: Data g???i k??m theo (optional)
                 *  Param3: h??m callBack t??? server
                 *  (optional, n???u kh??ng mu???n nh???n ack th?? d??ng socket.emit())
                 */
                socket!.emitWithAck("skipCount", {"skip": 10}, ack: (data) {
                  setState(() {
                    ackMessage =
                        "${data["message"]} ${DateTime.fromMillisecondsSinceEpoch(data["receivedAt"])}";
                  });
                });

                socket!.emit(
                    'commentSent', 'Comment : ${DateTime.now().toString()}');
              },
              child: const Text("Emit event to server"),
            ),
            ElevatedButton(
              onPressed: () {
                socket!.emit('joinPost', "619dc15f33f7df69c2201983");
              },
              child: const Text('Connect post'),
            ),
            ElevatedButton(
              onPressed: () {
                /**
                 * emitWithAck:
                 *  Param1: t??n event
                 *  Param2: Data g???i k??m theo (optional)
                 *  Param3: h??m callBack t??? server
                 *  (optional, n???u kh??ng mu???n nh???n ack th?? d??ng socket.emit())
                 */
                socket!.emit('leavePost');
              },
              child: const Text("Leave post"),
            ),
            Text(ackMessage),
          ],
        ),
      ),
    );
  }
}

class TempScreen2 extends StatelessWidget {
  const TempScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: GestureDetector(
          child: Text("Temp Screen2"),
          onTap: () {
            ///
            /// Khi mu???n push sang 1 screen n??o ???? ph???i s??? d???ng h??m d?????i ????y:
            /// rootNavigator: m???c ?????nh l?? false
            ///               false n???u mu???n hi???n th??? navigation bar,
            ///               true n???u mu???n ???n navigation bar khi sang screen mu???n push
            Navigator.of(context, rootNavigator: true).pushNamed(
                //Id c???a screen ???? khai b??o trong app_routes
                ReportProblemScreen.id,

                ///arguments l?? optional, c?? th??? l?? primitive type nh?? int, string,..
                ///ho???c class n???u c?? nhi???u argument cho d??? qu???n l??
                arguments: ReportProblemArguments("Some text"));
          },
        ),
      ),
    );
  }
}

class TempScreen3 extends StatelessWidget {
  const TempScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("Temp Screen3 test"),
      ),
    );
  }
}

// class HomeScreenArgument(){

// }

//endregion
