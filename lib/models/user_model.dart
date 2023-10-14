class UserDetails {
  final int id;
  final String name;
  final String picture;
  final Map statistics;

  const UserDetails({
    required this.id,
    required this.name,
    required this.picture,
    required this.statistics,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      picture: json.containsKey('picture') ? json['picture'] : '',
      statistics: json['anime_statistics'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'picture': picture,
        'anime_statistics': statistics,
      };
}
