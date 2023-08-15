class Point {
  final String pos;

  Point({
    required this.pos,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    print("ok15");
    return Point(
      pos: json["pos"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pos": pos,
      };
}
