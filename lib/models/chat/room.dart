import 'dart:convert';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

String roomToJson(Room data) => json.encode(data.toJson());

class Room {
  Room({
    required this.id,
    required this.name,
    required this.avatar,
    required this.listofUsers,
  });

  String id;
  String name;
  String avatar;
  List<String> listofUsers;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["_id"],
        name: json["name"],
        avatar: json["avatar"] ?? "",
        listofUsers: List<String>.from(json["listofUsers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatar": avatar,
        "listofUsers": List<dynamic>.from(listofUsers.map((x) => x)),
      };
}
