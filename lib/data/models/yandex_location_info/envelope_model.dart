class Envelope {
  final String lowerCorner;
  final String upperCorner;

  Envelope({
    required this.lowerCorner,
    required this.upperCorner,
  });

  factory Envelope.fromJson(Map<String, dynamic> json) {
    print("ok7");
    return Envelope(
      lowerCorner: json["lowerCorner"],
      upperCorner: json["upperCorner"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lowerCorner": lowerCorner,
        "upperCorner": upperCorner,
      };
}
