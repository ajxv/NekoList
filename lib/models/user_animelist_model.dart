// generated using https://app.quicktype.io

class UserAnimeList {
  final List<Data> data;
  final Paging paging;

  UserAnimeList({
    required this.data,
    required this.paging,
  });

  factory UserAnimeList.fromJson(Map<String, dynamic> json) {
    return UserAnimeList(
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      paging: Paging.fromJson(json["paging"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class Data {
  final Node node;
  final ListStatus listStatus;

  Data({
    required this.node,
    required this.listStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        node: Node.fromJson(json["node"]),
        listStatus: ListStatus.fromJson(json["list_status"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "list_status": listStatus.toJson(),
      };
}

class ListStatus {
  final String status;
  final int score;
  final bool isRewatching;
  final DateTime updatedAt;
  final int? numEpisodesWatched;

  ListStatus({
    required this.status,
    required this.score,
    required this.isRewatching,
    required this.updatedAt,
    this.numEpisodesWatched,
  });

  factory ListStatus.fromJson(Map<String, dynamic> json) => ListStatus(
        status: json["status"],
        score: json["score"],
        isRewatching: json["is_rewatching"],
        updatedAt: DateTime.parse(json["updated_at"]),
        numEpisodesWatched: json["num_episodes_watched"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "score": score,
        "is_rewatching": isRewatching,
        "updated_at": updatedAt.toIso8601String(),
        "num_episodes_watched": numEpisodesWatched,
      };
}

class Node {
  final int id;
  final String title;
  final MainPicture mainPicture;
  final int numEpisodes;

  Node({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.numEpisodes,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        mainPicture: MainPicture.fromJson(json["main_picture"]),
        numEpisodes: json['num_episodes'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
        "num_episodes": numEpisodes,
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

class Paging {
  final String next;

  Paging({
    required this.next,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        next: json["next"] != null ? json['next'] : "",
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
