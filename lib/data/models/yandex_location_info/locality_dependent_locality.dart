import 'package:google_location/data/models/yandex_location_info/dependent_locality_dependent_locality.dart';

class LocalityDependentLocality {
  final String dependentLocalityName;
  final DependentLocalityDependentLocality dependentLocality;

  LocalityDependentLocality({
    required this.dependentLocalityName,
    required this.dependentLocality,
  });

  factory LocalityDependentLocality.fromJson(Map<String, dynamic> json) {
    print('ok20');
    print(json);
    return LocalityDependentLocality(
      dependentLocalityName: json["DependentLocalityName"],
      dependentLocality: DependentLocalityDependentLocality.fromJson(json["DependentLocality"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "DependentLocalityName": dependentLocalityName,
        "DependentLocality": dependentLocality.toJson(),
      };
}
