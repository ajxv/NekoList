// generated using https://app.quicktype.io

import './manga_info_model.dart';

class UserMangaList {
  List<Datum> data;

  UserMangaList({
    required this.data,
  });

  factory UserMangaList.fromJson(Map<String, dynamic> json) => UserMangaList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Node node;
  MyListStatus listStatus;

  Datum({
    required this.node,
    required this.listStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        node: Node.fromJson(json["node"]),
        listStatus: MyListStatus.fromJson(json["list_status"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "list_status": listStatus.toJson(),
      };
}

// class ListStatus {
//   String status;
//   bool isRereading;
//   int numVolumesRead;
//   int numChaptersRead;
//   int score;
//   DateTime updatedAt;

//   ListStatus({
//     required this.status,
//     required this.isRereading,
//     required this.numVolumesRead,
//     required this.numChaptersRead,
//     required this.score,
//     required this.updatedAt,
//   });

//   factory ListStatus.fromJson(Map<String, dynamic> json) => ListStatus(
//         status: json["status"],
//         isRereading: json["is_rereading"],
//         numVolumesRead: json["num_volumes_read"],
//         numChaptersRead: json["num_chapters_read"],
//         score: json["score"],
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "is_rereading": isRereading,
//         "num_volumes_read": numVolumesRead,
//         "num_chapters_read": numChaptersRead,
//         "score": score,
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

class Node {
  int id;
  String title;
  MainPicture mainPicture;
  final int numChapters;

  Node({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.numChapters,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        mainPicture: MainPicture.fromJson(
          json.containsKey('main_picture')
              ? json["main_picture"]
              : {'medium': '', 'large': ''},
        ),
        numChapters: json['num_chapters'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
        "num_chapters": numChapters,
      };
}

class MainPicture {
  String medium;
  String large;

  MainPicture({
    required this.medium,
    required this.large,
  });

  factory MainPicture.fromJson(Map<String, dynamic> json) => MainPicture(
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "large": large,
      };
}
