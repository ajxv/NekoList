// generated using https://app.quicktype.io

class SearchResult {
  final List<Datum> data;

  SearchResult({
    required this.data,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
