import 'package:google_location/data/models/yandex_location_info/premise_model.dart';

class DependentLocalityDependentLocality {
  final String dependentLocalityName;
  final Premise premise;

  DependentLocalityDependentLocality({
    required this.dependentLocalityName,
    required this.premise,
  });

  factory DependentLocalityDependentLocality.fromJson(
      Map<String, dynamic> json) {
    print("ok21");
    print(json);
    return DependentLocalityDependentLocality(
      dependentLocalityName: json["DependentLocalityName"],
      premise: Premise.fromJson(json["Premise"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "DependentLocalityName": dependentLocalityName,
        "Premise": premise.toJson(),
      };
}
