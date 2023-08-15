import 'package:google_location/data/models/yandex_location_info/locality_dependent_locality.dart';

class Locality {
  final String localityName;
  final LocalityDependentLocality? dependentLocality;

  Locality({
    required this.localityName,
    required this.dependentLocality,
  });

  factory Locality.fromJson(Map<String, dynamic> json) {
    print('ok19');
    // print(json);

    return Locality(
      localityName: json["LocalityName"],
      dependentLocality: null,
      //     LocalityDependentLocality.fromJson(json["DependentLocality"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "LocalityName": localityName,
        "DependentLocality": dependentLocality?.toJson(),
      };
}
