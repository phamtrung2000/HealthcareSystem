import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 30.w),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                style: TextConfigs.kText18w400Black,
                onChanged: (v) {
                  setState(() => query = v);
                },
                decoration: InputDecoration(
                  suffix: query.isNotEmpty
                      ? GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            setState(() {
                              _controller.clear();
                              query = '';
                            });
                          },
                        )
                      : null,
                  hintText: 'Input',
                  hintStyle: TextConfigs.kText18w400Black,
                  fillColor: AppColors.kTextChatBackgroundColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 10,
                    borderSide: const BorderSide(
                      color: AppColors.kTextChatBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 10,
                    borderSide: const BorderSide(
                      color: AppColors.kTextChatBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              (query.isEmpty)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent search',
                          style: TextConfigs.kText24w400Black,
                        ),
                        ...recentSearchUser
                            .map(
                              (e) => ListTile(
                                minVerticalPadding: 20,
                                contentPadding: EdgeInsets.zero,
                                leading: const CircleAvatar(radius: 30),
                                title: Text(
                                  e.fullname,
                                  style: TextConfigs.kText20w400Black,
                                ),
                                // subtitle: e.role != null
                                //     ? Text(
                                //         e.role!,
                                //         style: TextConfigs.kText14w400Black,
                                //       )
                                //     : null,
                              ),
                            )
                            .toList(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Result',
                          style: TextConfigs.kText18w400Black,
                        ),
                        FutureBuilder(
                            future: DataProvider().getUsersByKeyword(query),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final listUser = snapshot.data as List<User>;

                                return SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listUser.length,
                                    itemBuilder: (_, index) {
                                      final user = listUser[index];
                                      return ListTile(
                                        minVerticalPadding: 20,
                                        contentPadding: EdgeInsets.zero,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              "${AppConfigs.apiUrl}/${user.avatar}"),
                                        ),
                                        title: Text(
                                          user.fullname,
                                          style: TextConfigs.kText20w400Black,
                                        ),
                                        // subtitle: Text(
                                        //   user.role == 1
                                        //       ? 'admin  '
                                        //       : 'customer',
                                        //   style: TextConfigs.kText14w400Black,
                                        // ),
                                      );
                                    },
                                  ),
                                );
                                Column(
                                  children: listUser
                                      .map(
                                        (user) {},
                                      )
                                      .toList(),
                                );
                              }
                              return Text('Loading');
                            }),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

final recentSearchUser = <User>[
  // User(fullname: 'Nguyen Van A', role: 'Expert'),
  // User(fullname: 'Tran Van B', role: 'Novice'),
  // User(fullname: 'Bui Thi C'),
];

final mockUser = <User>[];

// class User {
//   final String fullname;
//   final String? role;
//   final String? imageUrl;

//   User({
//     required this.fullname,
//     this.role,
//     this.imageUrl,
//   });
// }
