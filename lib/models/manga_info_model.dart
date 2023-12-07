// generated using https://app.quicktype.io

import 'anime_info_model.dart';

class MangaInfo {
  int id;
  String title;
  Picture mainPicture;
  AlternativeTitles alternativeTitles;
  DateTime? startDate;
  DateTime? endDate;
  String synopsis;
  double mean;
  int rank;
  int popularity;
  int numListUsers;
  int numScoringUsers;
  String nsfw;
  DateTime createdAt;
  DateTime updatedAt;
  String mediaType;
  String status;
  List<Genre> genres;
  MyListStatus? myListStatus;
  int? numVolumes;
  int numChapters;
  List<Author> authors;
  List<Picture> pictures;
  String background;
  List<RelatedAnime> relatedAnime;
  List<RelatedManga> relatedManga;
  List<Recommendation> recommendations;
  // List<Serialization> serialization;

  MangaInfo({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.alternativeTitles,
    required this.startDate,
    required this.endDate,
    required this.synopsis,
    required this.mean,
    required this.rank,
    required this.popularity,
    required this.numListUsers,
    required this.numScoringUsers,
    required this.nsfw,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaType,
    required this.status,
    required this.genres,
    required this.myListStatus,
    required this.numVolumes,
    required this.numChapters,
    required this.authors,
    required this.pictures,
    required this.background,
    required this.relatedAnime,
    required this.relatedManga,
    required this.recommendations,
    // required this.serialization,
  });

  factory MangaInfo.fromJson(Map<String, dynamic> json) => MangaInfo(
        id: json["id"],
        title: json["title"],
        mainPicture: Picture.fromJson(json["main_picture"]),
        alternativeTitles:
            AlternativeTitles.fromJson(json["alternative_titles"]),
        startDate: json['start_date'] != null
            ? DateTime.tryParse(json["start_date"])
            : null,
        endDate:
            json['end_date'] != null ? DateTime.parse(json["end_date"]) : null,
        synopsis: json["synopsis"],
        mean: json['mean'] != null ? json["mean"]?.toDouble() : 0,
        rank: json['rank'] != null ? json["rank"] : 0,
        popularity: json["popularity"],
        numListUsers: json["num_list_users"],
        numScoringUsers: json["num_scoring_users"],
        nsfw: json["nsfw"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mediaType: json["media_type"],
        status: json["status"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        myListStatus: json['my_list_status'] != null
            ? MyListStatus.fromJson(json["my_list_status"])
            : null,
        numVolumes: json["num_volumes"],
        numChapters: json["num_chapters"],
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        pictures: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
        background: json["background"],
        relatedAnime: List<RelatedAnime>.from(
            json["related_anime"].map((x) => RelatedAnime.fromJson(x))),
        relatedManga: List<RelatedManga>.from(
            json["related_manga"].map((x) => RelatedManga.fromJson(x))),
        recommendations: List<Recommendation>.from(
            json["recommendations"].map((x) => Recommendation.fromJson(x))),
        // serialization: List<Serialization>.from(
        // json["serialization"].map((x) => Serialization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
        "alternative_titles": alternativeTitles.toJson(),
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "synopsis": synopsis,
        "mean": mean,
        "rank": rank,
        "popularity": popularity,
        "num_list_users": numListUsers,
        "num_scoring_users": numScoringUsers,
        "nsfw": nsfw,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "media_type": mediaType,
        "status": status,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "my_list_status": myListStatus!.toJson(),
        "num_volumes": numVolumes,
        "num_chapters": numChapters,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
        "background": background,
        "related_anime":
            List<dynamic>.from(relatedAnime.map((x) => x.toJson())),
        "related_manga":
            List<dynamic>.from(relatedManga.map((x) => x.toJson())),
        "recommendations":
            List<dynamic>.from(recommendations.map((x) => x.toJson())),
        // "serialization":
        //     List<dynamic>.from(serialization.map((x) => x.toJson())),
      };
}

class AlternativeTitles {
  List<String> synonyms;
  String en;
  String ja;

  AlternativeTitles({
    required this.synonyms,
    required this.en,
    required this.ja,
  });

  factory AlternativeTitles.fromJson(Map<String, dynamic> json) =>
      AlternativeTitles(
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        en: json["en"],
        ja: json["ja"],
      );

  Map<String, dynamic> toJson() => {
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "en": en,
        "ja": ja,
      };
}

class Author {
  AuthorNode node;
  String role;

  Author({
    required this.node,
    required this.role,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        node: AuthorNode.fromJson(json["node"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "role": role,
      };
}

class AuthorNode {
  int id;
  String firstName;
  String lastName;

  AuthorNode({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory AuthorNode.fromJson(Map<String, dynamic> json) => AuthorNode(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
      };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Picture {
  String medium;
  String large;

  Picture({
    required this.medium,
    required this.large,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "large": large,
      };
}

class MyListStatus {
  String status;
  bool? isRereading;
  int? numVolumesRead;
  int numChaptersRead;
  int score;
  DateTime? updatedAt;

  MyListStatus({
    required this.status,
    this.isRereading,
    this.numVolumesRead,
    required this.numChaptersRead,
    required this.score,
    this.updatedAt,
  });

  factory MyListStatus.fromJson(Map<String, dynamic> json) => MyListStatus(
        status: json["status"],
        isRereading: json["is_rereading"],
        numVolumesRead: json["num_volumes_read"],
        numChaptersRead: json["num_chapters_read"],
        score: json["score"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "is_rereading": isRereading,
        "num_volumes_read": numVolumesRead,
        "num_chapters_read": numChaptersRead,
        "score": score,
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Recommendation {
  RecommendationNode node;
  int numRecommendations;

  Recommendation({
    required this.node,
    required this.numRecommendations,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        node: RecommendationNode.fromJson(json["node"]),
        numRecommendations: json["num_recommendations"],
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "num_recommendations": numRecommendations,
      };
}

class RecommendationNode {
  int id;
  String title;
  Picture mainPicture;

  RecommendationNode({
    required this.id,
    required this.title,
    required this.mainPicture,
  });

  factory RecommendationNode.fromJson(Map<String, dynamic> json) =>
      RecommendationNode(
        id: json["id"],
        title: json["title"],
        mainPicture: Picture.fromJson(
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

class RelatedManga {
  RecommendationNode node;
  String relationType;
  String relationTypeFormatted;

  RelatedManga({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  factory RelatedManga.fromJson(Map<String, dynamic> json) => RelatedManga(
        node: RecommendationNode.fromJson(json["node"]),
        relationType: json["relation_type"],
        relationTypeFormatted: json["relation_type_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "relation_type": relationType,
        "relation_type_formatted": relationTypeFormatted,
      };
}


// class Serialization {
//   Genre node;

//   Serialization({
//     required this.node,
//   });

//   factory Serialization.fromJson(Map<String, dynamic> json) => Serialization(
//         node: Genre.fromJson(json["node"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "node": node.toJson(),
//       };
// }
