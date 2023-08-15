class Location {
  int? id;
  final String title;
  final double lat;
  final double long;

  Location({
    this.id,
    required this.title,
    required this.lat,
    required this.long,
  });

  Location copyWith({
    int? id,
    String? title,
    double? lat,
    double? long,
  }) =>
      Location(
        id: id ?? this.id,
        title: title ?? this.title,
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        title: json["title"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "lat": lat,
        "long": long,
      };
}
