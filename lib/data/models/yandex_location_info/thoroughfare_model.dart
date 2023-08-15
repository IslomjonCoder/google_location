import 'premise_model.dart';

class Thoroughfare {
  final String thoroughfareName;
  final Premise premise;

  Thoroughfare({
    required this.thoroughfareName,
    required this.premise,
  });

  factory Thoroughfare.fromJson(Map<String, dynamic> json) {
    print("ok18");
    return Thoroughfare(
      thoroughfareName: json["ThoroughfareName"],
      premise: Premise.fromJson(json["Premise"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "ThoroughfareName": thoroughfareName,
        "Premise": premise.toJson(),
      };
}
