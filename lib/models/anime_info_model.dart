// generated using https://app.quicktype.io

class AnimeInfo {
  final int id;
  final String title;
  final Picture mainPicture;
  final AlternativeTitles alternativeTitles;
  final DateTime? startDate;
  final DateTime? endDate;
  final String synopsis;
  final double mean;
  final int rank;
  final int popularity;
  final int numListUsers;
  final int numScoringUsers;
  final String nsfw;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mediaType;
  final String status;
  final List<Genre> genres;
  final MyListStatus myListStatus;
  final int numEpisodes;
  final StartSeason startSeason;
  final String source;
  final int averageEpisodeDuration;
  final String rating;
  final List<Picture> pictures;
  final String background;
  final List<RelatedAnime> relatedAnime;
  final List<dynamic> relatedManga;
  final List<Recommendation> recommendations;
  final List<Genre> studios;
  final Statistics statistics;

  AnimeInfo({
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
    required this.numEpisodes,
    required this.startSeason,
    required this.source,
    required this.averageEpisodeDuration,
    required this.rating,
    required this.pictures,
    required this.background,
    required this.relatedAnime,
    required this.relatedManga,
    required this.recommendations,
    required this.studios,
    required this.statistics,
  });

  factory AnimeInfo.fromJson(Map<String, dynamic> json) => AnimeInfo(
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
        myListStatus: MyListStatus.fromJson(json["my_list_status"]),
        numEpisodes: json["num_episodes"],
        startSeason: StartSeason.fromJson(json["start_season"]),
        source: json["source"],
        averageEpisodeDuration: json["average_episode_duration"],
        rating: json["rating"],
        pictures: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
        background: json["background"],
        relatedAnime: List<RelatedAnime>.from(
            json["related_anime"].map((x) => RelatedAnime.fromJson(x))),
        relatedManga: List<dynamic>.from(json["related_manga"].map((x) => x)),
        recommendations: List<Recommendation>.from(
            json["recommendations"].map((x) => Recommendation.fromJson(x))),
        studios:
            List<Genre>.from(json["studios"].map((x) => Genre.fromJson(x))),
        statistics: Statistics.fromJson(json["statistics"]),
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
        "my_list_status": myListStatus.toJson(),
        "num_episodes": numEpisodes,
        "start_season": startSeason.toJson(),
        "source": source,
        "average_episode_duration": averageEpisodeDuration,
        "rating": rating,
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
        "background": background,
        "related_anime":
            List<dynamic>.from(relatedAnime.map((x) => x.toJson())),
        "related_manga": List<dynamic>.from(relatedManga.map((x) => x)),
        "recommendations":
            List<dynamic>.from(recommendations.map((x) => x.toJson())),
        "studios": List<dynamic>.from(studios.map((x) => x.toJson())),
        "statistics": statistics.toJson(),
      };
}

class AlternativeTitles {
  final List<String> synonyms;
  final String en;
  final String ja;

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

class Genre {
  final int id;
  final String name;

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
  final String medium;
  final String large;

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
  final String status;
  final int score;
  final int numEpisodesWatched;
  final bool isRewatching;
  final DateTime updatedAt;

  MyListStatus({
    required this.status,
    required this.score,
    required this.numEpisodesWatched,
    required this.isRewatching,
    required this.updatedAt,
  });

  factory MyListStatus.fromJson(Map<String, dynamic> json) => MyListStatus(
        status: json["status"],
        score: json["score"],
        numEpisodesWatched: json["num_episodes_watched"],
        isRewatching: json["is_rewatching"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "score": score,
        "num_episodes_watched": numEpisodesWatched,
        "is_rewatching": isRewatching,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Recommendation {
  final Node node;
  final int numRecommendations;

  Recommendation({
    required this.node,
    required this.numRecommendations,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        node: Node.fromJson(json["node"]),
        numRecommendations: json["num_recommendations"],
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "num_recommendations": numRecommendations,
      };
}

class Node {
  final int id;
  final String title;
  final Picture mainPicture;

  Node({
    required this.id,
    required this.title,
    required this.mainPicture,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        mainPicture: Picture.fromJson(json["main_picture"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture.toJson(),
      };
}

class RelatedAnime {
  final Node node;
  final String relationType;
  final String relationTypeFormatted;

  RelatedAnime({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  factory RelatedAnime.fromJson(Map<String, dynamic> json) => RelatedAnime(
        node: Node.fromJson(json["node"]),
        relationType: json["relation_type"],
        relationTypeFormatted: json["relation_type_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "relation_type": relationType,
        "relation_type_formatted": relationTypeFormatted,
      };
}

class StartSeason {
  final int year;
  final String season;

  StartSeason({
    required this.year,
    required this.season,
  });

  factory StartSeason.fromJson(Map<String, dynamic> json) => StartSeason(
        year: json["year"],
        season: json["season"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "season": season,
      };
}

class Statistics {
  final Status status;
  final int numListUsers;

  Statistics({
    required this.status,
    required this.numListUsers,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        status: Status.fromJson(json["status"]),
        numListUsers: json["num_list_users"],
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "num_list_users": numListUsers,
      };
}

class Status {
  final String watching;
  final String completed;
  final String onHold;
  final String dropped;
  final String planToWatch;

  Status({
    required this.watching,
    required this.completed,
    required this.onHold,
    required this.dropped,
    required this.planToWatch,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        watching: json["watching"],
        completed: json["completed"],
        onHold: json["on_hold"],
        dropped: json["dropped"],
        planToWatch: json["plan_to_watch"],
      );

  Map<String, dynamic> toJson() => {
        "watching": watching,
        "completed": completed,
        "on_hold": onHold,
        "dropped": dropped,
        "plan_to_watch": planToWatch,
      };
}
