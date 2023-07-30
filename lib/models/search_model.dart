// generated using https://app.quicktype.io

import 'dart:developer';

class SearchResult {
  final List<Datum> data;
  final Paging paging;

  SearchResult({
    required this.data,
    required this.paging,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class Datum {
  final Node node;

  Datum({
    required this.node,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        node: Node.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
      };
}

class Node {
  final int id;
  final String title;
  final MainPicture mainPicture;

  Node({
    required this.id,
    required this.title,
    required this.mainPicture,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        mainPicture: MainPicture.fromJson(
          json.containsKey('main_picture')
              ? json["main_picture"]
              : {'medium': '', 'large': ''},
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
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
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
