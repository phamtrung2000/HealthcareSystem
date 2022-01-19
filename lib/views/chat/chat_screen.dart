import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/chat/chat_message.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/chat/chat_room_message_provider.dart';
import 'package:flutter_mental_health/view_models/chat/list_user_provider.dart';
import 'package:flutter_mental_health/views/chat/widget/pop_menu_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

final TextEditingController _controller = TextEditingController();
bool isSuggestionShown = false;

class ChatScreen extends StatelessWidget {
  static const id = "chat_screen";

  final String roomId;
  final String roomName;
  const ChatScreen({Key? key, required this.roomId, required this.roomName})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChatPage(
      title: roomName,
      roomId: roomId,
    );
  }
}

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.title, required this.roomId})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String roomId;

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
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
                  DataRepository().userExitChatRoom(
                      widget.roomId, context.read<AuthProvider>().user.id);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            actions: [
              context.read<AuthProvider>().user.role == 1
                  ? MyPopMenuButton(
                      roomId: widget.roomId,
                    )
                  : SizedBox(),
            ],
            centerTitle: true,
            foregroundColor: AppColors.kBlackColor,
            backgroundColor: AppColors.kPopupBackgroundColor,
            //backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              widget.title,
              style: TextConfigs.kText24w400Black,
            ),
          ),
        ),
        body:
            Consumer<ChatMessageProvider>(builder: (context, provider, index) {
          return Column(
            children: [
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: provider.chatMessages.length,
                        itemBuilder: (context, index) => Message(
                          message: provider.chatMessages[index],
                        ),
                      ))),
              //Spacer(),
              BottomTextField(roomID: widget.roomId, roomName: widget.title)
            ],
          );
        }));
  }
}

TextEditingController inputMessage = TextEditingController();
ScrollController scrollController = ScrollController();
final List<User>? users = ListUserProvider().allUser;

class BottomTextField extends StatefulWidget {
  const BottomTextField({
    Key? key,
    required this.roomID,
    required this.roomName,
  }) : super(key: key);

  final String roomID;
  final String roomName;

  @override
  State<BottomTextField> createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField>
    with SingleTickerProviderStateMixin {
  OverlayEntry? entry;
  final LayerLink _layerLink = LayerLink();
  late AnimationController animController;

  bool isOpenSticker = false;

  bool isBanded = false;

  String inputHint() {
    if (isBanded == true)
      return "You can not send message";
    else
      return "Input message here...";
  }

  ImagePicker _picker = ImagePicker();

  // final List<User>? users = ListUserProvider().allUser;

  _showSuggestion() {
    if (isSuggestionShown) return;
    setState(() {
      isSuggestionShown = true;
    });
    entry = OverlayEntry(
      builder: (_) => TagSuggestion(
        layerLink: _layerLink,
        animController: animController,
      ),
    );
    final OverlayState? overlayState = Overlay.of(context);
    overlayState!.insert(entry!);
    animController.addListener(() {
      overlayState.setState(() {});
    });
    animController.forward();
  }

  _closeSuggestion() async {
    if (!isSuggestionShown) return;
    setState(() {
      isSuggestionShown = false;
    });
    await animController.reverse();
    entry!.remove();
  }

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        height: 50.h,
        decoration: const BoxDecoration(
          color: AppColors.kPopupBackgroundColor,
        ),
        child: SafeArea(
            child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle,
                color: AppColors.kIconColor,
                size: 35.sp,
              ),
            ),
            SizedBox(width: 7.w),
            Expanded(
              child: Container(
                height: 38.h,
                decoration: BoxDecoration(
                  color: isBanded
                      ? AppColors.kGreyBackgroundColor
                      : AppColors.kTextChatBackgroundColor,
                  borderRadius: BorderRadius.circular(18.sp),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 17.w),
                    Expanded(
                        child: TextField(
                      enabled: isBanded ? false : true,
                      controller: inputMessage,
                      onChanged: (inputMessage) {
                        //inputMessage = val;
                        var lastVal =
                            inputMessage.substring(inputMessage.length - 1);
                        //print(lastVal);
                        if (lastVal.contains("@")) {
                          _showSuggestion();
                        } else {
                          _closeSuggestion();
                        }
                      },
                      style: TextConfigs.kText18w400Black,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: (isBanded)
                            ? "You can not send message"
                            : "Input message here...",
                        border: InputBorder.none,
                      ),
                    )),
                    //SizedBox(width: 17.w),
                    Icon(
                      Icons.alternate_email,
                      color: isSuggestionShown
                          ? AppColors.kIconColor
                          : AppColors.kGreyTextTouchableColor,
                    ),
                    SizedBox(width: 16.w),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5.w),
            IconButton(
              onPressed: () async {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut);

                context
                    .read<ChatMessageProvider>()
                    .sendTextMessage(inputMessage.text, widget.roomID);
                inputMessage.text = "";
                setState(() {});

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ChatScreen(
                //             roomId: widget.roomID,
                //             roomName: widget.roomName,
                //           )),
                // );
              },
              icon: Icon(
                Icons.send_rounded,
                color: AppColors.kIconColor,
                size: 35.sp,
              ),
            ),
            SizedBox(width: 9.w),
          ],
        )),
      ),
    );
  }
}

class TagSuggestion extends StatelessWidget {
  const TagSuggestion({
    Key? key,
    required LayerLink layerLink,
    required this.animController,
  })  : _layerLink = layerLink,
        super(key: key);

  final LayerLink _layerLink;
  final AnimationController animController;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      followerAnchor: Alignment.bottomLeft,
      link: _layerLink,
      showWhenUnlinked: false,
      child: Material(
        color: AppColors.kGreyBackgroundColor.withOpacity(0.7),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CircularRevealAnimation(
            animation: animController,
            centerAlignment: Alignment.bottomCenter,
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.w)),
                  color: AppColors.kPopupBackgroundColor),
              constraints: BoxConstraints(maxHeight: 200.h),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    var lastVal = inputMessage.text
                        .substring(inputMessage.text.length - 1);
                    if (lastVal.contains("@")) {
                      inputMessage.text = inputMessage.text
                          .substring(0, inputMessage.text.length - 1);
                    }
                    ;
                    inputMessage.text =
                        inputMessage.text + "|" + users![index].id + "|";
                    print(inputMessage);
                    inputMessage.selection = TextSelection.fromPosition(
                        TextPosition(offset: inputMessage.text.length));
                  },
                  title: Text("@" + users![index].fullname),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.kButtonColor,
                    //backgroundImage: suggestions![index].avatar,
                  ),
                ),
                itemCount: users!.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(
            message: message,
          );
          break;
        case ChatMessageType.image:
          return ImageMessage(message: message);
          break;
        default:
          return SizedBox();
      }
    }

    return Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            InkWell(
                onTap: () {
                  showReport(context);
                },
                child: CircleAvatar(
                  radius: 17.sp,
                  backgroundImage:
                      AssetImage('assets/images/avatar.png') as ImageProvider,
                ))
          ],
          SizedBox(
            width: 7.w,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 12.h,
            ),
            if (!message.isSender) ...[
              Container(
                margin: EdgeInsets.only(left: 8.w),
                //alignment: Alignment.bottomLeft,
                child:
                    Text(message.userId, style: TextConfigs.kText14w400Black),
              ),
            ],
            messageContaint(message),
          ])
        ]);
  }

  void showReport(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.w),
          topRight: Radius.circular(15.w),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 290.h,
          decoration: BoxDecoration(
              color: AppColors.kPopupBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.w),
                topLeft: Radius.circular(15.w),
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(''),
                      Container(
                          margin: EdgeInsets.only(left: 40.h),
                          width: 80.w,
                          height: 80.h,
                          child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'))),
                      IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ]),
                Text(
                  'Fullname',
                  style: TextConfigs.kText24w400Black,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 18.h),
                  child: Text(
                    'email or phone number',
                    style: TextConfigs.kText18w400Black
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 18.w, right: 19.w, top: 10.h),
                    child: TextButton(
                        onPressed: () {},
                        child: Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Icon(Icons.dnd_forwardslash,
                                size: 40.w, color: AppColors.kIconColor),
                          ),
                          Text(
                            'Report user',
                            style: TextConfigs.kText20w400Black,
                          )
                        ]))),
                Container(
                    margin: EdgeInsets.only(left: 18.w, right: 19.w, top: 10.h),
                    child: TextButton(
                        onPressed: () {},
                        child: Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Icon(Icons.notifications,
                                size: 40.w, color: AppColors.kIconColor),
                          ),
                          Text(
                            'Get notification',
                            style: TextConfigs.kText20w400Black,
                          )
                        ]))),
                Container(
                    margin: EdgeInsets.only(top: 33.h),
                    child: SizedBox(
                        width: 362.w,
                        height: 43.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.kButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0.w),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextConfigs.kText12w400White,
                          ),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatScreenArgument {
  String roomName;
  String idRoom;
  ChatScreenArgument(this.roomName, this.idRoom);
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  List<InlineSpan> get listInline {
    List<InlineSpan> line = [];
    List<String> splitMessage = message.content.split("|");
    for (var split in splitMessage) {
      for (var user in users!) {
        //print(user.id);
        print(split);
        if (split == user.id) {
          line.add(TextSpan(
              text: '@' + user.fullname + " ",
              style: TextConfigs.kText14w400BlueUnderLine));
          split = "";
        }
      }
      line.add(
          TextSpan(text: split + " ", style: TextConfigs.kText14w400Black));
      //print(split);
      //print(users!.length);
    }
    return line;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            constraints: BoxConstraints(maxWidth: 250.w, minHeight: 30.h),
            decoration: BoxDecoration(
              color: message.isSender
                  ? AppColors.kChatMessegeSenderColor
                  : AppColors.kChatMessegeColor,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Container(
                margin: EdgeInsets.all(8.sp),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 40),
                    children: listInline,
                  ),
                ))),
        // Positioned(
        //     top: -34.0,
        //     child: Container(
        //         width: 220.w,
        //         height: 35.h,
        //         decoration: BoxDecoration(
        //           color: AppColors.kBlack54Color,
        //         )))
      ],
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.sp),
          child: Image.asset(message.content),
        ));
  }
}
