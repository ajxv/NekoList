// generated using https://app.quicktype.io

import './anime_info_model.dart';

class UserAnimeList {
  final List<Data> data;

  UserAnimeList({
    required this.data,
  });

  factory UserAnimeList.fromJson(Map<String, dynamic> json) {
    return UserAnimeList(
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  final Node node;
  final MyListStatus listStatus;

  Data({
    required this.node,
    required this.listStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        node: Node.fromJson(json["node"]),
        listStatus: MyListStatus.fromJson(json["list_status"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "list_status": listStatus.toJson(),
      };
}

// class ListStatus {
//   final String status;
//   final int score;
//   final bool isRewatching;
//   final DateTime updatedAt;
//   final int? numEpisodesWatched;

//   ListStatus({
//     required this.status,
//     required this.score,
//     required this.isRewatching,
//     required this.updatedAt,
//     this.numEpisodesWatched,
//   });

//   factory ListStatus.fromJson(Map<String, dynamic> json) => ListStatus(
//         status: json["status"],
//         score: json["score"],
//         isRewatching: json["is_rewatching"],
//         updatedAt: DateTime.parse(json["updated_at"]),
//         numEpisodesWatched: json["num_episodes_watched"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "score": score,
//         "is_rewatching": isRewatching,
//         "updated_at": updatedAt.toIso8601String(),
//         "num_episodes_watched": numEpisodesWatched,
//       };
// }

class Node {
  final int id;
  final String title;
  final MainPicture mainPicture;
  final int numEpisodes;
  final String airingStatus;

  Node({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.numEpisodes,
    required this.airingStatus,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        mainPicture: MainPicture.fromJson(
          json.containsKey('main_picture')
              ? json["main_picture"]
              : {'medium': '', 'large': ''},
        ),
        numEpisodes: json['num_episodes'],
        airingStatus: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
        "num_episodes": numEpisodes,
        'airing_status': airingStatus,
      };
}

class MainPicture {
  final String medium;
  final String large;

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
