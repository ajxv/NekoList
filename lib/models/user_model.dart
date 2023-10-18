// generated using https://app.quicktype.io

class UserDetails {
  int id;
  String name;
  String picture;
  String location;
  DateTime joinedAt;
  Map<String, double> animeStatistics;

  UserDetails({
    required this.id,
    required this.name,
    required this.picture,
    required this.location,
    required this.joinedAt,
    required this.animeStatistics,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        name: json["name"],
        picture: json.containsKey('picture') ? json["picture"] : '',
        location: json["location"],
        joinedAt: DateTime.parse(json["joined_at"]),
        animeStatistics: Map.from(json["anime_statistics"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "location": location,
        "joined_at": joinedAt.toIso8601String(),
        "anime_statistics": Map.from(animeStatistics)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
