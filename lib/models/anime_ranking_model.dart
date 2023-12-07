// generated using https://javiercbk.github.io/json_to_dart/ and painfully edited

class AnimeRanking {
  List<Data> data;

  AnimeRanking({required this.data});

  factory AnimeRanking.fromJson(Map<String, dynamic> json) {
    return AnimeRanking(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Node node;
  Ranking ranking;

  Data({
    required this.node,
    required this.ranking,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        node: Node.fromJson(json['node']),
        ranking: Ranking.fromJson(json['ranking']),
      );

  Map<String, dynamic> toJson() => {
        'node': node.toJson(),
        'ranking': ranking.toJson(),
      };
}

class Node {
  int id;
  String title;
  MainPicture mainPicture;
  double? meanScore;

  Node({
    required this.id,
    required this.title,
    required this.mainPicture,
    this.meanScore,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json['id'],
        title: json['title'],
        mainPicture: MainPicture.fromJson(
          json.containsKey('main_picture')
              ? json["main_picture"]
              : {'medium': '', 'large': ''},
        ),
        meanScore: json['mean'] != null ? json["mean"]?.toDouble() : 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
        "meanScore": meanScore,
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

class Ranking {
  int rank;

  Ranking({
    required this.rank,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) =>
      Ranking(rank: json['rank']);

  Map<String, dynamic> toJson() => {
        'rank': rank,
      };
}

class AnimeSuggestion {
  List<Datum> data;

  AnimeSuggestion({
    required this.data,
  });

  factory AnimeSuggestion.fromJson(Map<String, dynamic> json) {
    return AnimeSuggestion(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Node node;

  Datum({
    required this.node,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        node: Node.fromJson(json['node']),
      );

  Map<String, dynamic> toJson() => {
        'node': node.toJson(),
      };
}
