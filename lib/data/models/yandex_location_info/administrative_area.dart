import 'package:google_location/data/models/yandex_location_info/locality_model.dart';

class AdministrativeArea {
  final String administrativeAreaName;
  final Locality locality;

  AdministrativeArea({
    required this.administrativeAreaName,
    required this.locality,
  });

  factory AdministrativeArea.fromJson(Map<String, dynamic> json) {
    print("ok3");
    return AdministrativeArea(
      administrativeAreaName: json["AdministrativeAreaName"],
      locality: Locality.fromJson(json["Locality"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "AdministrativeAreaName": administrativeAreaName,
        "Locality": locality.toJson(),
      };
}
